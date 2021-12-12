//
//  LocalDataSource.swift
//  Core
//
//  Created by Budi Darmawan on 05/12/21.
//

import RxSwift

public protocol LocaleDataSource {
  associatedtype Request
  associatedtype Response
  
  func getBookmarkMovies() -> Observable<Response>
  func getMovie(id: Request) -> Observable<Response>
  func addToLocal(entities: ObjMovie) -> Observable<Bool?>
  func deleteFromLocal(id: Request) -> Observable<Bool?>
}
