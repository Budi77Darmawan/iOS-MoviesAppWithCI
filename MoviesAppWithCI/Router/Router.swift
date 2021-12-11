//
//  Router.swift
//  MoviesAppWithCI
//
//  Created by Budi Darmawan on 11/12/21.
//

import UIKit
import Home
import Core

public class Router {
  static let bundleHome = "com.bd-drmwan.Home"
  
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
    > = Injection.init().provideMovies()
    
    homeVC.viewModel = HomeViewModel(useCase: useCase)
    
    return homeVC
  }
}
