//
//  ProfileViewController.swift
//  Profile
//
//  Created by Budi Darmawan on 12/12/21.
//

import UIKit
import Core
import CommonExt

public class ProfileViewController: UIViewController {
  
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var informationCard: UIView!
  @IBOutlet weak var contactStaticLabel: UILabel!
  @IBOutlet weak var academyStaticLabel: UILabel!
  @IBOutlet weak var pointsStaticlabel: UILabel!
  @IBOutlet weak var iconPhoneImage: UIImageView!
  @IBOutlet weak var iconMailImage: UIImageView!
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    profileImage.makeRounded()
    profileImage.image = UIImage(named: "img_photo_profile")
    informationCard.backgroundColor = .white
    informationCard.cornerRadius(15)
    informationCard.makeShadow()
    
    iconPhoneImage.image = UIImage(named: "ic_phone")
    iconMailImage.image = UIImage(named: "ic_mail")
    contactStaticLabel.text = "contact".localized()
    academyStaticLabel.text = "academy".localized()
    pointsStaticlabel.text = "point".localized()
  }
  
}
