//
//  DetailViewModel.swift
//  Home
//
//  Created by Budi Darmawan on 11/12/21.
//

import RxSwift
import Core

public class DetailViewModel<
  MovieUseCase: UseCase,
  MoviesLocaleUseCase: UseCase
>: ObservableObject
where
MovieUseCase.Request == String, MovieUseCase.Response == MovieModel,
MoviesLocaleUseCase.Request == MovieModel, MoviesLocaleUseCase.Response == Bool {
  private let disposeBag = DisposeBag()
  private let _movieUseCase: MovieUseCase
  private let _moviesLocaleUseCase: MoviesLocaleUseCase
  
  let result = PublishSubject<MovieModel>()
  private let _movieId: Int
  private var movie: MovieModel?
  
  public init(
    movieId: Int,
    movieUseCase: MovieUseCase,
    moviesLocaleUseCase: MoviesLocaleUseCase
  ) {
    self._movieId = movieId
    self._movieUseCase = movieUseCase
    self._moviesLocaleUseCase = moviesLocaleUseCase
  }
  
  func getMovie() {
    self._movieUseCase.execute(request: String(_movieId))
      .observeOn(MainScheduler.instance)
      .subscribe { result in
        
        self.movie = result
        guard let result = result else { return }
        self.result.onNext(result)
      } onError: { error in
        self.result.onError(error)
      } onCompleted: {
      }
      .disposed(by: disposeBag)
  }
  
  func updatesBookmarkMovie() {
    self._moviesLocaleUseCase.execute(request: movie)
      .observeOn(MainScheduler.instance)
      .subscribe { _ in
        guard var movie = self.movie else { return }
        movie.isBookmark = !movie.isBookmark
        self.movie = movie
        self.result.onNext(movie)
      } onError: { error in
        self.result.onError(error)
      } onCompleted: {
      }
      .disposed(by: disposeBag)
  }
}
