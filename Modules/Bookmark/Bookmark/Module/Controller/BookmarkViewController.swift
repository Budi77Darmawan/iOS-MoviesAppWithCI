//
//  BookmarkViewController.swift
//  Bookmark
//
//  Created by Budi Darmawan on 12/12/21.
//

import UIKit
import Core
import RxSwift
import CommonExt
import SharedView

public class BookmarkViewController: UIViewController {
  
  public var viewModel: BookmarkViewModel<
    Interactor<String, [MovieModel], GetMoviesBookmarkRepository<MoviesBookmarkDataSource>>
  >?
  
  @IBOutlet weak var moviesTableView: UITableView!
  
  private let disposeBag = DisposeBag()
  private var movies: [MovieModel] = []
  
  public override func viewWillAppear(_ animated: Bool) {
    viewModel?.getMovies()
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    initTableView()
    initObservers()
  }
  
  private func initTableView() {
    moviesTableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
    moviesTableView.delegate = self
    moviesTableView.dataSource = self
    moviesTableView.tableFooterView = UIView()
  }
  
  private func initObservers() {
    viewModel?.result
      .subscribe( onNext: { res in
        self.movies = res
        if self.movies.isEmpty {
          self.moviesTableView.setBackground(imageName: "img_empty_items", messageImage: "no_items".localized())
          return
        }
        self.moviesTableView.reloads()
        self.moviesTableView.clearBackground()
      }, onError: { error in
        let message = error.localizedDescription
        self.moviesTableView.setBackground(imageName: "img_error_connection", messageImage: message)
      })
      .disposed(by: disposeBag)
  }
  
}

// MARK: TableView
extension BookmarkViewController: UITableViewDelegate, UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    movies.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
      return UITableViewCell()
    }
    cell.configureCell(with: movies[indexPath.row])
    return cell
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let movieId = movies[indexPath.row].id
    viewModel?.navigateToDetail(viewController: self, movieId: movieId)
  }
  
}
