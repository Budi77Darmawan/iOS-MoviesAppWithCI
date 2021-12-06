//
//  Interactor.swift
//  Core
//
//  Created by Budi Darmawan on 05/12/21.
//

import Foundation
import RxSwift

public protocol UseCase {
  associatedtype Request
  associatedtype Response
  
  func execute(request: Request?) -> Observable<Response?>
}

public struct Interactor<
  Request, Response,
  R: Repository
>: UseCase
where R.Request == Request, R.Response == Response {
  
  private let _repository: R
  
  public init(repository: R) {
    _repository = repository
  }
  
  public func execute(request: Request?) -> Observable<Response?> {
    _repository.execute(request: request)
  }
}
