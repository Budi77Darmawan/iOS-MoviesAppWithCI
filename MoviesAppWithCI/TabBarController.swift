//
//  ViewController.swift
//  MoviesAppWithCI
//
//  Created by Budi Darmawan on 05/12/21.
//

import UIKit
import Home

class TabBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  private func makeNavigation(viewController: UIViewController) -> UINavigationController {
    let navigation = UINavigationController(rootViewController: viewController)
    navigation.navigationBar.prefersLargeTitles = false
    return navigation
  }
  
  func makeTabBar() -> TabBarController {
    self.viewControllers = [
      makeNavigation(viewController: HomeRouter.makeHomeView())
    ]
    return self
  }
  
}