//
//  LocalDataSource.swift
//  Core
//
//  Created by Budi Darmawan on 05/12/21.
//

import RxSwift

public protocol LocalDataSource {
  associatedtype Request
  associatedtype Response
  
  func getDataLocal() -> Observable<[Response]>
  func addToLocal(entities: Response) -> Observable<Bool>
  func deleteFromLocal(id: String) -> Observable<Bool>
}
