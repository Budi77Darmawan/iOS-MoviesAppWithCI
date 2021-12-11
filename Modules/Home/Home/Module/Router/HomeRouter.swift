//
//  HomeRouter.swift
//  Home
//
//  Created by Budi Darmawan on 11/12/21.
//

import UIKit
import Core

final class HomeRouter {
  static let bundleHome = "com.bd-drmwan.Home"
  
  static func navigateToDetailView(viewController: UIViewController) {
    let detailVC = DetailViewController(
      nibName: "DetailViewController",
      bundle: Bundle(identifier: bundleHome)
    )
    viewController.navigationController?.pushViewController(detailVC, animated: true)
  }
  
}
