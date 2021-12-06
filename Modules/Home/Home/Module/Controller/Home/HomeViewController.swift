//
//  HomeViewController.swift
//  Home
//
//  Created by Budi Darmawan on 05/12/21.
//

import UIKit
import CommonExt

class HomeViewController: UIViewController {
  
  @IBOutlet weak var moviesTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initTableView()
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
    HomeRouter.navigateToDetailView(viewController: self)
  }
  
  @objc
  private func refreshTableView() {
//    self.list.removeAll()
//    self.homeViewModel?.getMovie(type: EnumMovie.popular)
  }

}

// MARK: TableView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    list.count
    0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
      return UITableViewCell()
    }
//    cell.config(movie: list[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let movieId = list[indexPath.row].id
//    homeViewModel?.navigateToDetail(viewController: self, movieId: movieId)
  }
  
}
