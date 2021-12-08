//
//  GetMoviesDataSource.swift
//  Home
//
//  Created by Budi Darmawan on 07/12/21.
//

import Core
import RxSwift

public struct GetMoviesRemoteDataSource : RemoteDataSource {
    
    public typealias Request = String
    public typealias Response = MoviesResponse
    
  private let _endpoint: Endpoints.Movie
    
    public init(endpoint: Endpoints.Movie) {
        _endpoint = endpoint
    }
    
    public func execute(request: Request?) -> Observable<Response?> {
      let api = _endpoint
      let url = URL(string: _endpoint.url)
      let data: Observable<Response?> = NetworkCall().executeQuery(url: url, method: api.method, params: api.params(parameters: nil))
      return data
    }

}
