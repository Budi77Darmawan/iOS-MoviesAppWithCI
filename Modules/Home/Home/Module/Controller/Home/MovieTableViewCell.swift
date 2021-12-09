//
//  MovieTableViewCell.swift
//  Home
//
//  Created by Budi Darmawan on 10/12/21.
//

import UIKit
import Core

class MovieTableViewCell: UITableViewCell {
  
  static let identifier = "MovieTableViewCell"
  static func nib() -> UINib {
    return UINib(nibName: "MovieTableViewCell",
                 bundle: Bundle(identifier: "com.bd-drmwan.Home"))
  }
  
  @IBOutlet weak var movieImage: UIImageView!
  @IBOutlet weak var movieTitle: UILabel!
  @IBOutlet weak var movieDescription: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func configureCell(with movie: MovieModel) {
    movieTitle.text = movie.title
    movieDescription.text = movie.overview
    movieImage.loadImage(uri: movie.posterPath)
  }
  
}
