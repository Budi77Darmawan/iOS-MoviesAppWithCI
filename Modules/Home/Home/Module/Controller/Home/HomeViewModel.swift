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
  private var _navigateToDetail: ((UIViewController, Int) -> ())?
  
  typealias Router = HomeRouter
  
  let result = PublishSubject<[MovieModel]>()
  
  public init(useCase: MoviesUseCase, navigateToDetail: @escaping ((UIViewController, Int) -> ())) {
    self._moviesUseCase = useCase
    self._navigateToDetail = navigateToDetail
  }
  
  func getMovies() {
    self._moviesUseCase.execute(request: nil)
      .observeOn(MainScheduler.instance)
      .subscribe { result in
        self.result.onNext(result ?? [])
      } onError: { error in
        self.result.onError(error)
      } onCompleted: {
      }
      .disposed(by: disposeBag)
  }
  
  func navigateToDetail(viewController: UIViewController, movieId: Int) {
//    Router.navigateToDetailView(viewController: viewController)
    _navigateToDetail?(viewController, movieId)
  }
}
