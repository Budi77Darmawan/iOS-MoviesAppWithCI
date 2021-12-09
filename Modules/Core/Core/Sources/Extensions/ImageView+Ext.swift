//
//  ImageView+Ext.swift
//  Core
//
//  Created by Budi Darmawan on 10/12/21.
//

import SDWebImage

extension UIImageView {
  public func loadImage(uri: String?) {
    let imageUrl =
      uri?.isEmpty ?? true ? URL(string: API.defaultUriImage) : URL(string: API.baseUrlImage + uri!)
    self.sd_setImage(with: imageUrl, completed: nil)
  }
}
