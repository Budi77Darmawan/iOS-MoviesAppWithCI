//
//  NetworkCall.swift
//  Core
//
//  Created by Budi Darmawan on 07/12/21.
//

import Alamofire
import RxSwift

public struct API {
  static let apiKey = "868a6974fc6a1cdf9b8f926aa5f1880c"
  static let baseUrl = "https://api.themoviedb.org/3/movie/"
  static let baseUrlImage = "https://image.tmdb.org/t/p/w500"
  static let defaultUriImage = "https://www.logistec.com/wp-content/uploads/2017/12/placeholder.png"
}

public protocol Endpoint {
  var url: String { get }
  var method: HTTPMethod { get }
  func params(parameters: Parameters?) -> Parameters
}

public enum Endpoints {
//  public typealias EnumMovie = Endpoints.Movie
  
  public enum Movie: Endpoint {
    case popular
    case topRated
    case detail(movieId: Int)
    
    public var url: String {
      switch self {
      case .popular: return "\(API.baseUrl)popular"
      case .topRated: return "\(API.baseUrl)top_rated"
      case .detail(movieId: let movieId):
        return "\(API.baseUrl)\(movieId)"
      }
    }
    
    public var method: HTTPMethod {
      switch self {
      case .popular: return .get
      default: return .get
      }
    }
    
    public func params(parameters: Parameters?) -> Parameters {
      let paramAPIKey: Parameters = [
        "api_key": API.apiKey,
        "language": "en-US"
      ]
      
      guard var params = parameters else {
        return paramAPIKey
      }
      params.merge(paramAPIKey) { first, _ in
        first
      }
      return params
    }
  }
}

public class NetworkCall: NSObject {
  public func executeQuery<T> (url: URL?,
                        method: HTTPMethod,
                        params: Parameters
  ) -> Observable<T> where T: Decodable {
    return Observable<T>.create({ observer in
      guard let url = url else {
        observer.onError(URLError.invalidRequest)
        return Disposables.create()
      }
      
      AF.request(url, method: method, parameters: params)
        .validate(statusCode: 200...299)
        .responseJSON { response in
          switch response.result {
          case .success:
            guard let data = response.data else {
              return
            }
            DispatchQueue.main.async {
              do {
                let result = try JSONDecoder().decode(T.self, from: data)
                observer.onNext(result)
                observer.onCompleted()
              } catch let error {
                observer.onError(error)
              }
            }
          case .failure(let error):
            DispatchQueue.main.async {
              observer.onError(error)
            }
          }
        }
      return Disposables.create()
    })
  }
}

public enum URLError: LocalizedError {
    case invalidRequest
    case invalidResponse
    case addressUnreachable(URL)
    
    public var errorDescription: String? {
        switch self {
        case .invalidRequest: return "Request is null."
        case .invalidResponse: return "The server responded with garbage."
        case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
        }
    }
}
