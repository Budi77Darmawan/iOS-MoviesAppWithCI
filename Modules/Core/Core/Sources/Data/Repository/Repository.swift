//
//  Repository.swift
//  Core
//
//  Created by Budi Darmawan on 05/12/21.
//

import RxSwift

public protocol Repository {
  associatedtype Request
  associatedtype Response
  
  func execute(request: Request?) -> Observable<Response?>
}
