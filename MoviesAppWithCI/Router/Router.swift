//
//  Router.swift
//  MoviesAppWithCI
//
//  Created by Budi Darmawan on 11/12/21.
//

import UIKit
import Core
import Home
import Bookmark

public class Router {
  static let bundleHome = "com.bd-drmwan.Home"
  static let bundleBookmark = "com.bd-drmwan.Bookmark"
  
  private static let injection = Injection.init()
  
  public static func makeHomeView() -> UIViewController {
    let homeVC = HomeViewController(
      nibName: "HomeViewController",
      bundle: Bundle(identifier: bundleHome)
    )
    homeVC.title = "home_title".localized()
    homeVC.tabBarItem = UITabBarItem(title: "home_title_bar".localized(), image: UIImage(systemName: "play.fill"), tag: 0)
    
    let useCase: Interactor<
      String,
      [MovieModel],
      GetMoviesRepository<
        GetMoviesRemoteDataSource>
    > = injection.provideMovies()
    
    homeVC.viewModel = HomeViewModel(useCase: useCase) { viewContoller, movieId in
      navigateToDetail(viewController: viewContoller, movieId: movieId)
    }
    
    return homeVC
  }
  
  public static func makeBookmarkView() -> UIViewController {
    let bokmarkVC = BookmarkViewController(
      nibName: "BookmarkViewController",
      bundle: Bundle(identifier: bundleBookmark)
    )
    bokmarkVC.title = "bookmark_title".localized()
    bokmarkVC.tabBarItem = UITabBarItem(title: "bookmark_title_bar".localized(), image: UIImage(systemName: "bookmark.fill"), tag: 1)
    
    let useCase: Interactor<
      String,
      [MovieModel],
      GetMoviesBookmarkRepository<
        MoviesBookmarkDataSource>
    > = injection.provideMovieBookmark()
    
    bokmarkVC.viewModel = BookmarkViewModel(useCase: useCase) { viewContoller, movieId in
      navigateToDetail(viewController: viewContoller, movieId: movieId)
    }
    
    return bokmarkVC
  }
  
  public static func navigateToDetail(viewController: UIViewController, movieId: Int) {
    let detailVC = DetailViewController(
      nibName: "DetailViewController",
      bundle: Bundle(identifier: bundleHome)
    )
    
    let movieUseCase: Interactor<
      String,
      MovieModel,
      GetMovieRepository<
        GetMovieRemoteDataSource,
        MoviesLocaleDataSource>
    > = injection.provideMovie(movieId: movieId)
    
    let movieLocaleUseCase: Interactor<
      MovieModel,
      Bool,
      UpdateBookmarkMovieRepository<
        MoviesLocaleDataSource>
    > = injection.provideMovieLocale()
    
    detailVC.viewModel = DetailViewModel(movieId: movieId, movieUseCase: movieUseCase, moviesLocaleUseCase: movieLocaleUseCase)
    
    viewController.navigationController?.pushViewController(detailVC, animated: true)
  }
  
}
