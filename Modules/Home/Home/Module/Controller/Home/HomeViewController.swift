//
//  HomeViewController.swift
//  Home
//
//  Created by Budi Darmawan on 05/12/21.
//

import UIKit
import CommonExt
import Core

public class HomeViewController: UIViewController {
  
  public var viewModel: HomeViewModel<
    Interactor<String, [MovieModel], GetMoviesRepository<GetMoviesRemoteDataSource>>
  >? = nil
  
  @IBOutlet weak var moviesTableView: UITableView!
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    initTableView()
    viewModel?.getMovies()
  }
  
  private func initTableView() {
    moviesTableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
    moviesTableView.delegate = self
    moviesTableView.dataSource = self
    moviesTableView.tableFooterView = UIView()
    moviesTableView.refreshControl = UIRefreshControl()
    moviesTableView.refreshControl?.beginRefreshing()
    moviesTableView.refreshControl?.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
//    moviesTableView.setBackground(imageName: "person.fill", messageImage: "No action")
  }
  
  @IBAction func navigateToDetail(_ sender: Any) {
//    HomeRouter.navigateToDetailView(viewController: self)
  }
  
  @objc
  private func refreshTableView() {
//    self.list.removeAll()
//    self.homeViewModel?.getMovie(type: EnumMovie.popular)
  }

}

// MARK: TableView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    list.count
    0
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
      return UITableViewCell()
    }
//    cell.config(movie: list[indexPath.row])
    return cell
  }
  
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let movieId = list[indexPath.row].id
//    homeViewModel?.navigateToDetail(viewController: self, movieId: movieId)
  }
  
}
