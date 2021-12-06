//
//  HomeRouter.swift
//  Home
//
//  Created by Budi Darmawan on 05/12/21.
//

import Foundation
import UIKit

public class HomeRouter {
  static let bundleHome = "com.bd-drmwan.Home"
  
  public static func makeHomeView() -> UIViewController {
    let homeVC = HomeViewController(
      nibName: "HomeViewController",
      bundle: Bundle(identifier: bundleHome)
    )
    homeVC.title = "Discover"
    homeVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "play.fill"), tag: 0)
    return homeVC
  }
  
  public static func navigateToDetailView(viewController: UIViewController) {
    let detailVC = DetailViewController(
      nibName: "DetailViewController",
      bundle: Bundle(identifier: bundleHome)
    )
    viewController.navigationController?.pushViewController(detailVC, animated: true)
  }
  
}
