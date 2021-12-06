//
//  DetailViewController.swift
//  Home
//
//  Created by Budi Darmawan on 06/12/21.
//

import UIKit
import CommonExt

class DetailViewController: UIViewController {
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.tabBar.invisible()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.tabBarController?.tabBar.visible()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Detail"
    // Do any additional setup after loading the view.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
