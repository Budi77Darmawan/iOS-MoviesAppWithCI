//
//  GetMovieRepository.swift
//  Home
//
//  Created by Budi Darmawan on 11/12/21.
//

import Core
import RxSwift
import RealmSwift

public struct GetMovieRepository<
  MovieRemoteDataSource: RemoteDataSource,
  MovieLocaleDataSource: MoviesLocaleDataSource
>: Repository
where
MovieRemoteDataSource.Request == String,
MovieRemoteDataSource.Response == DetailsMovieResponse,
MovieLocaleDataSource.Request == String,
MovieLocaleDataSource.Response == Results<ObjMovie> {
  
  public typealias Request = String
  public typealias Response = MovieModel
  
  private let _remoteDataSource: MovieRemoteDataSource
  private let _localDataSource: MovieLocaleDataSource
  
  public init(
    remoteDataSource: MovieRemoteDataSource,
    localeDataSource: MovieLocaleDataSource
  ) {
    _remoteDataSource = remoteDataSource
    _localDataSource = localeDataSource
  }
  
  public func execute(request: String?) -> Observable<MovieModel?> {
    self._localDataSource.getMovie(id: request ?? "0")
      .map { DataMapper.mapListObjMovieToListMovie(list: $0).first { movie in String(movie.id) == request } }
      .filter { $0 != nil }
      .ifEmpty(switchTo: self._remoteDataSource.execute(request: request)
                .map { DataMapper.mapDetailResponseToMovieModel(data: $0!) }
      )
    
  }
}
