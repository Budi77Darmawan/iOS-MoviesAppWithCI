//
//  Injection.swift
//  MoviesAppWithCI
//
//  Created by Budi Darmawan on 07/12/21.
//

import UIKit
import RealmSwift
import Core
import Home

final class Injection: NSObject {
  func provideMovies<U: UseCase>() -> U where U.Request == String, U.Response == [MovieModel] {
    let remote = GetMoviesRemoteDataSource(endpoint: Endpoints.Movie.popular)
    let repository = GetMoviesRepository(remoteDataSource: remote)
    return Interactor(repository: repository) as! U
  }
}