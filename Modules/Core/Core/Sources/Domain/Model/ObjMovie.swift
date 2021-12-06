//
//  ObjMovie.swift
//  Core
//
//  Created by Budi Darmawan on 05/12/21.
//

import Foundation
import RealmSwift

public class ObjMovie: Object {
  @objc dynamic var adult: Bool = false
  @objc dynamic var backdropPath: String = ""
  @objc dynamic var id: Int = 0
  @objc dynamic var overview: String = ""
  @objc dynamic var popularity: Double = 0.0
  @objc dynamic var posterPath: String = ""
  @objc dynamic var releaseDate: String = ""
  @objc dynamic var runtime: Int = 0
  @objc dynamic var title: String = ""
  @objc dynamic var voteAverage: Double = 0.0
  @objc dynamic var voteCount: Int = 0
  @objc dynamic var isBookmark: Bool = false
  
  var genres: List<ObjGenre> = List()
  var productionCompanies: List<ObjProductionCompany> = List()
  var productionCountries: List<ObjProductionCountry> = List()
  
  public override class func primaryKey() -> String? {
    return "id"
  }
}

public class ObjGenre: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var name: String = ""
}

public class ObjProductionCompany: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var name: String = ""
  @objc dynamic var logoPath: String = ""
  @objc dynamic var originCountry: String = ""
}

public class ObjProductionCountry: Object {
  @objc dynamic var name: String = ""
}
