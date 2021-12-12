//
//  GetMoviesBookmarkRepository.swift
//  Bookmark
//
//  Created by Budi Darmawan on 12/12/21.
//

import Core
import RxSwift
import RealmSwift

public struct GetMoviesBookmarkRepository<
  MoviesLocaleDataSource: LocaleDataSource
>: Repository
where
MoviesLocaleDataSource.Request == String,
MoviesLocaleDataSource.Response == Results<ObjMovie> {
  
  public typealias Request = String
  public typealias Response = [MovieModel]
  
  private let _localeDataSource: MoviesLocaleDataSource
  
  public init(
    localeDataSource: MoviesLocaleDataSource
  ) {
    _localeDataSource = localeDataSource
  }
  
  public func execute(request: String?) -> Observable<[MovieModel]?> {
    return self._localeDataSource.getBookmarkMovies()
      .map { DataMapper.mapListObjMovieToListMovie(list: $0) }
  }
}
