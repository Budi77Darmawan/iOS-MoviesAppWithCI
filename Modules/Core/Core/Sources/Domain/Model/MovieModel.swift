//
//  MovieModel.swift
//  Core
//
//  Created by Budi Darmawan on 05/12/21.
//

public struct MovieModel: Codable {
  let adult: Bool
  let backdropPath: String?
  let genres: [Genre]?
  let id: Int
  let overview: String
  let popularity: Double
  let posterPath: String?
  let releaseDate: String
  let runtime: Int?
  let title: String
  let voteAverage: Double
  let voteCount: Int
  var isBookmark: Bool = false
  
  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case genres, id
    case overview, popularity
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case runtime, title
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
    case isBookmark
  }
}
