//
//  MovieTableViewCell.swift
//  Home
//
//  Created by Budi Darmawan on 05/12/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
  static let identifier = "MovieTableViewCell"
  static func nib() -> UINib {
    return UINib(nibName: "MovieTableViewCell",
                 bundle: nil)
  }
  
  @IBOutlet weak var movieImage: UIImageView!
  @IBOutlet weak var movieTitleLabel: UILabel!
  @IBOutlet weak var movieDescriptionLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
//  func config(movie: MovieModel) {
//    movieTitleLabel.text = movie.title
//    movieDescriptionLabel.text = movie.overview
    //    imgMovie.loadImage(uri: movie.posterPath)
//  }
  
}
