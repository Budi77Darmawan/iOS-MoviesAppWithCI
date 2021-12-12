//
//  BookmarkViewController.swift
//  Bookmark
//
//  Created by Budi Darmawan on 12/12/21.
//

import UIKit
import Core
import RxSwift
import RxCocoa
import CommonExt
import SharedView

public class BookmarkViewController: UIViewController {
  
  public var viewModel: BookmarkViewModel<
    Interactor<String, [MovieModel], GetMoviesBookmarkRepository<MoviesBookmarkDataSource>>
  >?
  
  private let searchController = UISearchController(searchResultsController: nil)
  @IBOutlet weak var moviesTableView: UITableView!
  
  private let disposeBag = DisposeBag()
  private var movies: [MovieModel] = []
  
  public override func viewWillAppear(_ animated: Bool) {
    let query = searchController.searchBar.text?.trimmingCharacters(in: .whitespaces)
    viewModel?.getMovies(query: query)
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    initTableView()
    initSearchView()
    initObservers()
  }
  
  private func initTableView() {
    moviesTableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
    moviesTableView.delegate = self
    moviesTableView.dataSource = self
    moviesTableView.tableFooterView = UIView()
  }
  
  private func initSearchView() {
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    
    searchController.searchBar
      .rx.text
      .debounce(.milliseconds(600), scheduler: MainScheduler.instance)
      .subscribe(onNext: { query in
        guard let querySearch = query else { return }
        let queryTrim = querySearch.trimmingCharacters(in: .whitespaces)
        self.viewModel?.getMovies(query: queryTrim)
      })
      .disposed(by: disposeBag)
  }
  
  private func initObservers() {
    viewModel?.result
      .subscribe( onNext: { res in
        self.movies = res
        self.moviesTableView.reloads()
        if self.movies.isEmpty {
          let query = self.searchController.searchBar.text?.trimmingCharacters(in: .whitespaces)
          let image = query?.isEmpty == true ? "img_empty_items" : "img_error_search"
          let message = query?.isEmpty == true ? "no_items".localized() : "\"\(query!)\"" + "not_found".localized()
          self.moviesTableView.setBackground(imageName: image, messageImage: message)
        } else {
          self.moviesTableView.clearBackground()
        }
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
