//
//  MovieTableViewCell.swift
//  SharedView
//
//  Created by Budi Darmawan on 12/12/21.
//

import UIKit
import Core

public class MovieTableViewCell: UITableViewCell {
  
  public static let identifier = "MovieTableViewCell"
  public static func nib() -> UINib {
    return UINib(nibName: "MovieTableViewCell",
                 bundle: Bundle(identifier: "com.bd-drmwan.SharedView"))
  }
  
  @IBOutlet weak var movieImage: UIImageView!
  @IBOutlet weak var movieTitle: UILabel!
  @IBOutlet weak var movieDescription: UILabel!
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    self.selectionStyle = .none
    // Initialization code
  }
  
  public override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  public func configureCell(with movie: MovieModel) {
    movieTitle.text = movie.title
    movieDescription.text = movie.overview
    movieImage.loadImage(uri: movie.posterPath)
  }
  
}
