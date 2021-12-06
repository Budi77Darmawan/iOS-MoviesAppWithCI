//
//  SingleViewModel.swift
//  Core
//
//  Created by Budi Darmawan on 06/12/21.
//

import Foundation
import RxSwift

public class SingleViewModel<
  Request, Response,
  Interactor: UseCase
>: ObservableObject where Interactor.Request == Request, Interactor.Response == Response {
  
  private let disposeBag = DisposeBag()
  private let _useCase: Interactor
  
  public let result = PublishSubject<Response?>()
  
  public init(useCase: Interactor) {
    _useCase = useCase
  }
  
  public func getList(request: Request?) {
    _useCase.execute(request: request)
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
