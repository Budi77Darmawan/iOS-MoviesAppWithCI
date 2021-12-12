//
//  DataMapper.swift
//  Core
//
//  Created by Budi Darmawan on 05/12/21.
//

import Foundation
import RealmSwift

public final class DataMapper {
  
  public static func mapMoviesResponseToMovieModel(data: MoviesResponse?) -> [MovieModel] {
    guard let listMovie = data?.results else { return [] }
    return listMovie.map { movie in
      MovieModel(adult: movie.adult, backdropPath: movie.backdropPath, genres: nil, id: movie.id, overview: movie.overview.isEmpty ? "---" : movie.overview, popularity: movie.popularity, posterPath: movie.posterPath, releaseDate: movie.releaseDate, runtime: nil, title: movie.title, voteAverage: movie.voteAverage, voteCount: movie.voteCount)
    }
  }
  
  public static func mapDetailResponseToMovieModel(data: DetailsMovieResponse) -> MovieModel {
    return MovieModel(adult: data.adult, backdropPath: data.backdropPath, genres: data.genres, id: data.id, overview: data.overview.isEmpty ? "---" : data.overview, popularity: data.popularity, posterPath: data.posterPath, releaseDate: data.releaseDate, runtime: data.runtime, title: data.title, voteAverage: data.voteAverage, voteCount: data.voteCount)
  }
  
  public static func mapListToString(from data: [Genre], separator: String = ",") -> String {
    return data.map { $0.name }.joined(separator: separator)
  }
  
  public static func mapMinutesToHoursMinutes (from minute : Int) -> String {
    let hours = minute / 60
    let minutes = minute % 60
    let strHours = "hours".localized()
    let strMinutes = "minutes".localized()
    return "\(hours)\(strHours) \(minutes)\(strMinutes)"
  }
  
  public static func mapMovieModelToObjMovie(data: MovieModel) -> ObjMovie {
    let objDetailMovie = ObjMovie()
    objDetailMovie.adult = data.adult
    objDetailMovie.backdropPath = data.backdropPath ?? ""
    objDetailMovie.id = data.id
    objDetailMovie.overview = data.overview
    objDetailMovie.popularity = data.popularity
    objDetailMovie.posterPath = data.posterPath ?? ""
    objDetailMovie.releaseDate = data.releaseDate
    objDetailMovie.runtime = data.runtime ?? 0
    objDetailMovie.title = data.title
    objDetailMovie.voteAverage = data.voteAverage
    objDetailMovie.voteCount = data.voteCount
    objDetailMovie.isBookmark = data.isBookmark
    
    let dataGenre: List<ObjGenre> = List.init()
    _ = data.genres?.map {
      let gen = ObjGenre()
      gen.id = $0.id
      gen.name = $0.name
      dataGenre.append(gen)
    }
    objDetailMovie.genres = dataGenre
    
    return objDetailMovie
  }
  
  public static func mapListObjMovieToListMovie(list: Results<ObjMovie>) -> [MovieModel] {
    return list.toArray(ofType: ObjMovie.self).map {
      mapObjMovieToMovieModel(data: $0)
    }
  }
  
  public static func mapObjMovieToMovieModel(data: ObjMovie) -> MovieModel {
    let genres: [Genre] = data.genres.map { gen in Genre(id: gen.id, name: gen.name) }
    return MovieModel(adult: data.adult, backdropPath: data.backdropPath, genres: genres, id: data.id, overview: data.overview, popularity: data.popularity, posterPath: data.posterPath, releaseDate: data.releaseDate, runtime: data.runtime, title: data.title, voteAverage: data.voteAverage, voteCount: data.voteCount, isBookmark: data.isBookmark)
  }
}

extension Results {

  public func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}
