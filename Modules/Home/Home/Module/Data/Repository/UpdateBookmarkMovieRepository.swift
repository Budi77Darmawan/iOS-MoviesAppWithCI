//
//  UpdateBookmarkMovieRepository.swift
//  Home
//
//  Created by Budi Darmawan on 11/12/21.
//

import Core
import RxSwift
import CommonExt
import RealmSwift

public struct UpdateBookmarkMovieRepository<
  MovieLocaleDataSource: MoviesLocaleDataSource
>: Repository
where
MovieLocaleDataSource.Request == String,
MovieLocaleDataSource.Response == Results<ObjMovie> {
  
  public typealias Request = MovieModel
  public typealias Response = Bool
  
  private let _localDataSource: MovieLocaleDataSource
  
  public init(
    localeDataSource: MovieLocaleDataSource
  ) {
    _localDataSource = localeDataSource
  }
  
  public func execute(request: MovieModel?) -> Observable<Bool?> {
    guard var movie = request else {
      return .error(DatabaseError.requestFailed)
    }

    if movie.isBookmark {
      return self._localDataSource.deleteFromLocal(id: String(movie.id))
    } else {
      movie.isBookmark = true
      return self._localDataSource.addToLocal(entities: DataMapper.mapMovieModelToObjMovie(data: movie))
    }
  }
  
}
