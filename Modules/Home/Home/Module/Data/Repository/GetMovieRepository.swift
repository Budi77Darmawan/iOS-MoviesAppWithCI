//
//  GetMovieRepository.swift
//  Home
//
//  Created by Budi Darmawan on 11/12/21.
//

import Core
import RxSwift

public struct GetMovieRepository<
  MovieRemoteDataSource: RemoteDataSource
>: Repository
where
MovieRemoteDataSource.Request == String,
MovieRemoteDataSource.Response == DetailsMovieResponse {
  
  public typealias Request = String
  public typealias Response = MovieModel
  
  private let _remoteDataSource: MovieRemoteDataSource
  
  public init(
    remoteDataSource: MovieRemoteDataSource
  ) {
    _remoteDataSource = remoteDataSource
  }
  
  public func execute(request: String?) -> Observable<MovieModel?> {
    self._remoteDataSource.execute(request: request)
      .map {
        guard let movie = $0 else { return nil }
        return DataMapper.mapDetailResponseToMovieModel(data: movie)
      }
  }
}
