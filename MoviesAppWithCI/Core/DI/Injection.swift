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
import Bookmark

final class Injection: NSObject {
  
  func provideMovies<U: UseCase>() -> U where U.Request == String, U.Response == [MovieModel] {
    let remote = GetMoviesRemoteDataSource(endpoint: Endpoints.Movie.popular)
    let repository = GetMoviesRepository(remoteDataSource: remote)
    return Interactor(repository: repository) as! U
  }
  
  func provideMovie<U: UseCase>(movieId: Int) -> U where U.Request == String, U.Response == MovieModel {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let locale = MoviesLocaleDataSource(realm: appDelegate.realm)
    let remote = GetMovieRemoteDataSource(endpoint: Endpoints.Movie.detail(movieId: movieId))
    let repository = GetMovieRepository(remoteDataSource: remote, localeDataSource: locale)
    return Interactor(repository: repository) as! U
  }
  
  func provideMovieLocale<U: UseCase>() -> U where U.Request == MovieModel, U.Response == Bool {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let locale = MoviesLocaleDataSource(realm: appDelegate.realm)
    let repository = UpdateBookmarkMovieRepository(localeDataSource: locale)
    return Interactor(repository: repository) as! U
  }
  
  func provideMovieBookmark<U: UseCase>() -> U where U.Request == String, U.Response == [MovieModel] {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let locale = MoviesBookmarkDataSource(realm: appDelegate.realm)
    let repository = GetMoviesBookmarkRepository(localeDataSource: locale)
    return Interactor(repository: repository) as! U
  }
}
