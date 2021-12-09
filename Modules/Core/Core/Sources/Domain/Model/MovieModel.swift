//
//  MovieModel.swift
//  Core
//
//  Created by Budi Darmawan on 05/12/21.
//

public struct MovieModel: Codable {
  public let adult: Bool
  public let backdropPath: String?
  public let genres: [Genre]?
  public let id: Int
  public let overview: String
  public let popularity: Double
  public let posterPath: String?
  public let releaseDate: String
  public let runtime: Int?
  public let title: String
  public let voteAverage: Double
  public let voteCount: Int
  public var isBookmark: Bool = false
  
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
