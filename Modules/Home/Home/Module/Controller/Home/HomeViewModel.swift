//
//  HomeViewModel.swift
//  Home
//
//  Created by Budi Darmawan on 08/12/21.
//

import RxSwift
import Core

public class HomeViewModel<
  MoviesUseCase: UseCase
>: ObservableObject
where
MoviesUseCase.Request == String, MoviesUseCase.Response == [MovieModel] {
  private let disposeBag = DisposeBag()
  private let _moviesUseCase: MoviesUseCase
  private var _navigateToDetail: ((UIViewController, Int) -> Void)?
  
  let result = PublishSubject<[MovieModel]>()
  private var movies = [MovieModel]()
  private var pages = 1
  private var onLoadNextPage = false
  
  public init(useCase: MoviesUseCase, navigateToDetail: @escaping ((UIViewController, Int) -> Void)) {
    self._moviesUseCase = useCase
    self._navigateToDetail = navigateToDetail
  }
  
  func getMovies(_ lastMovie: MovieModel?) {
    if !isLoadNextPage(lastMovie) {
      return
    }
    
    self.onLoadNextPage = true
    self._moviesUseCase.execute(request: String(pages))
      .observeOn(MainScheduler.instance)
      .subscribe { result in
        self.onLoadNextPage = false
        self.pages += 1
        guard let movies = result else { return }
        self.movies.append(contentsOf: movies)
        self.result.onNext(self.movies)
      } onError: { error in
        self.onLoadNextPage = false
        self.result.onError(error)
      } onCompleted: {
      }
      .disposed(by: disposeBag)
  }
  
  func refreshMovies() {
    self.pages = 1
    self.movies = []
    getMovies(nil)
  }
  
  func navigateToDetail(viewController: UIViewController, movieId: Int) {
    _navigateToDetail?(viewController, movieId)
  }
  
  private func isLoadNextPage(_ lastMovie: MovieModel?) -> Bool {
    guard let movie = lastMovie else { return true }
    if onLoadNextPage {
      return false
    } else {
      if pages > 4 {
        return false
      } else {
        if movies[movies.count-1].id != movie.id {
          return false
        }
        return true
      }
    }
  }
  
}
