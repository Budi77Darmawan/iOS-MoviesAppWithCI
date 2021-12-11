//
//  DetailViewModel.swift
//  Home
//
//  Created by Budi Darmawan on 11/12/21.
//

import RxSwift
import Core

public class DetailViewModel<
  MovieUseCase: UseCase
>: ObservableObject
where
MovieUseCase.Request == String, MovieUseCase.Response == MovieModel {
  private let disposeBag = DisposeBag()
  private let _movieUseCase: MovieUseCase
  
  let result = PublishSubject<MovieModel?>()
  
  public init(useCase: MovieUseCase) {
    self._movieUseCase = useCase
  }
  
  func getMovie() {
    self._movieUseCase.execute(request: nil)
      .observeOn(MainScheduler.instance)
      .subscribe { result in
        self.result.onNext(result)
      } onError: { error in
        self.result.onError(error)
      } onCompleted: {
      }
      .disposed(by: disposeBag)
  }
}
