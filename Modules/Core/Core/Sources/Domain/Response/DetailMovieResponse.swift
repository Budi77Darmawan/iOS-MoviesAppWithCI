//
//  DetailMovieResponse.swift
//  Core
//
//  Created by Budi Darmawan on 05/12/21.
//

// MARK: - DetailsMovieResponse
public struct DetailsMovieResponse: Codable {
    let adult: Bool
    let backdropPath: String
    let genres: [Genre]
    let id: Int
    let originalTitle, overview: String
    let popularity: Double
    let posterPath: String
//    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let runtime: Int
    let status, title: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genres, id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
//        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case runtime
        case status, title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Genre
public struct Genre: Codable {
    let id: Int
    let name: String
}

// MARK: - ProductionCompany
// struct ProductionCompany: Codable {
//    let id: Int
//    let logoPath, name, originCountry: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case logoPath = "logo_path"
//        case originCountry = "origin_country"
//    }
// }

// MARK: - ProductionCountry
public struct ProductionCountry: Codable {
    let name: String
}
