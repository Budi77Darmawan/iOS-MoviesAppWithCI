//
//  DetailViewController.swift
//  Home
//
//  Created by Budi Darmawan on 06/12/21.
//

import UIKit
import Core
import CommonExt
import RxSwift

public class DetailViewController: UIViewController {
  
  public var viewModel: DetailViewModel<
    Interactor<String, MovieModel, GetMovieRepository<GetMovieRemoteDataSource, MoviesLocaleDataSource>>,
    Interactor<MovieModel, Bool, UpdateBookmarkMovieRepository<MoviesLocaleDataSource>>
  >?
  
  private let disposeBag = DisposeBag()
  
  @IBOutlet weak var backdropImage: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var runtimeLabel: UILabel!
  @IBOutlet weak var bookmarkButton: UIButton!
  @IBOutlet weak var posterImage: UIImageView!
  @IBOutlet weak var overviewStaticLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.tabBar.invisible()
  }
  
  public override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.tabBarController?.tabBar.visible()
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    overviewStaticLabel.text = "overview".localized()
    
    initObservers()
    viewModel?.getMovie()
  }
  
  private func initObservers() {
    viewModel?.result
      .subscribe( onNext: { movie in
        self.setupView(with: movie)
        self.setupButtonBookmark(isBookmark: movie.isBookmark)
      }, onError: { _ in
      })
      .disposed(by: disposeBag)
  }
  
  private func setupView(with movie: MovieModel) {
    self.title = movie.title
    titleLabel.text = movie.title
    backdropImage.loadImage(uri: movie.backdropPath)
    posterImage.loadImage(uri: movie.posterPath)
    posterImage.cornerRadius(8)
    genreLabel.text = DataMapper.mapListToString(from: movie.genres ?? [])
    overviewLabel.text = movie.overview
    runtimeLabel.text = "runtime".localized() + ": \(DataMapper.mapMinutesToHoursMinutes(from: movie.runtime ?? 0))"
    bookmarkButton.addTarget(self, action: #selector(updatesBookmarkMovie), for: .touchUpInside)
  }
  
  @objc
  private func updatesBookmarkMovie() {
    viewModel?.updatesBookmarkMovie()
  }
  
  private func setupButtonBookmark(isBookmark: Bool) {
    if isBookmark {
      bookmarkButton.setTitle("bookmarked".localized(), for: .normal)
      bookmarkButton.setTitleColor(.white, for: .normal)
      bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
      bookmarkButton.tintColor = .white
      bookmarkButton.backgroundColor = .systemBlue
    } else {
      bookmarkButton.setTitle("bookmark".localized(), for: .normal)
      bookmarkButton.setTitleColor(.systemBlue, for: .normal)
      bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
      bookmarkButton.tintColor = .systemBlue
      bookmarkButton.backgroundColor = .clear
    }
    bookmarkButton.cornerRadius(8)
    bookmarkButton.layer.borderWidth = 1
    bookmarkButton.layer.borderColor = UIColor.systemBlue.cgColor
  }
}
