//
//  HomeRouter.swift
//  MoviesAppWithCI
//
//  Created by Budi Darmawan on 08/12/21.
//

import Home
import UIKit
import Core

public class HomeRouter {
  static let bundleHome = "com.bd-drmwan.Home"
  
  public static func makeHomeView() -> UIViewController {
    let homeVC = HomeViewController(
      nibName: "HomeViewController",
      bundle: Bundle(identifier: bundleHome)
    )
    homeVC.title = "Discover"
    homeVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "play.fill"), tag: 0)
    
    let useCase: Interactor<
        String,
        [MovieModel],
        GetMoviesRepository<
            GetMoviesRemoteDataSource>
    > = Injection.init().provideMovies()
    
    homeVC.viewModel = HomeViewModel(useCase: useCase)
    
    return homeVC
  }
  
//  public static func navigateToDetailView(viewController: UIViewController) {
//    let detailVC = DetailViewController(
//      nibName: "DetailViewController",
//      bundle: Bundle(identifier: bundleHome)
//    )
//    viewController.navigationController?.pushViewController(detailVC, animated: true)
//  }
  
}
