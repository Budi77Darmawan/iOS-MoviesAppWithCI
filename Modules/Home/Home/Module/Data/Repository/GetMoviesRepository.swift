//
//  GetMoviesRepository.swift
//  Home
//
//  Created by Budi Darmawan on 07/12/21.
//

import Core
import RxSwift

public struct GetMoviesRepository<
  MoviesRemoteDataSource: RemoteDataSource
>: Repository
where
MoviesRemoteDataSource.Request == String,
MoviesRemoteDataSource.Response == MoviesResponse {
  
  public typealias Request = String
  public typealias Response = [MovieModel]
  
  private let _remoteDataSource: MoviesRemoteDataSource
  
  public init(
    remoteDataSource: MoviesRemoteDataSource
  ) {
    _remoteDataSource = remoteDataSource
  }
  
  public func execute(request: String?) -> Observable<[MovieModel]?> {
    return self._remoteDataSource.execute(request: request)
      .map { DataMapper.mapMoviesResponseToMovieModel(data: $0) }
  }
}
