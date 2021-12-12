//
//  HomeViewController.swift
//  Home
//
//  Created by Budi Darmawan on 05/12/21.
//

import UIKit
import CommonExt
import Core
import RxSwift
import SharedView

public class HomeViewController: UIViewController {
  
  public var viewModel: HomeViewModel<
    Interactor<String, [MovieModel], GetMoviesRepository<GetMoviesRemoteDataSource>>
  >?
  
  private let disposeBag = DisposeBag()
  private var movies: [MovieModel] = []
  
  @IBOutlet weak var moviesTableView: UITableView!
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    initTableView()
    viewModel?.getMovies(nil)
    
    viewModel?.result
      .subscribe( onNext: { res in
        self.movies = res
        if self.movies.isEmpty {
          self.moviesTableView.setBackground(imageName: "img_empty_items", messageImage: "No items")
          return
        }
        self.moviesTableView.reloads()
        self.moviesTableView.endRefreshControl()
        self.moviesTableView.clearBackground()
      }, onError: { error in
        let message = error.localizedDescription
        self.moviesTableView.setBackground(imageName: "img_error_connection", messageImage: message)
      })
      .disposed(by: disposeBag)
  }
  
  private func initTableView() {
    moviesTableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
    moviesTableView.delegate = self
    moviesTableView.dataSource = self
    moviesTableView.tableFooterView = UIView()
    moviesTableView.refreshControl = UIRefreshControl()
    moviesTableView.refreshControl?.beginRefreshing()
    moviesTableView.refreshControl?.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
  }
  
  @objc
  private func refreshTableView() {
    self.viewModel?.refreshMovies()
  }

}

// MARK: TableView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    movies.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
      return UITableViewCell()
    }
    let movie = movies[indexPath.row]
    cell.configureCell(with: movie)
    self.viewModel?.getMovies(movie)
    return cell
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let movieId = movies[indexPath.row].id
    viewModel?.navigateToDetail(viewController: self, movieId: movieId)
  }
  
}
