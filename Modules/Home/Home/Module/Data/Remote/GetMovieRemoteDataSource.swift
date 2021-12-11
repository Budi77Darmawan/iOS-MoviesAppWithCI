//
//  GetMovieRemoteDataSource.swift
//  Home
//
//  Created by Budi Darmawan on 11/12/21.
//

import Core
import RxSwift

public struct GetMovieRemoteDataSource : RemoteDataSource {
    
    public typealias Request = String
    public typealias Response = DetailsMovieResponse
    
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
