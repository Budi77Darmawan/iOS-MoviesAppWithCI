//
//  LocaleDataSource.swift
//  Home
//
//  Created by Budi Darmawan on 07/12/21.
//

import RealmSwift
import Core
import RxSwift
import CommonExt

public class MoviesLocaleDataSource: LocaleDataSource {
  public typealias Request = Int
  public typealias Response = ObjMovie
  
  private let _realm: Realm
  
  public init(realm: Realm) {
    _realm = realm
  }
  
  public func getBookmarkMovies() -> Observable<[ObjMovie]> {
    return Observable<[ObjMovie]>.create { observer in
        do {
          try self._realm.write {
            let list = self._realm.objects(ObjMovie.self)
              .sorted(byKeyPath: "title", ascending: true)
            observer.onNext(list.toArray(ofType: ObjMovie.self))
            observer.onCompleted()
          }
        } catch {
          observer.onError(DatabaseError.requestFailed)
        }
      return Disposables.create()
    }
  }
  
  public func getMovie(id: Int) -> Observable<ObjMovie> {
    return Observable<ObjMovie>.create { observer in
        do {
          try self._realm.write {
            let result = self._realm.objects(ObjMovie.self)
              .filter("id = %@", id)
            
            guard let movie = result.first else {
              observer.onError(DatabaseError.requestFailed)
              return
            }
            observer.onNext(movie)
            observer.onCompleted()
          }
        } catch {
          observer.onError(DatabaseError.requestFailed)
        }
      return Disposables.create()
    }
  }
  
  public func addToLocal(entities: ObjMovie) -> Observable<Bool> {
    return Observable<Bool>.create { observer in
      do {
        try self._realm.write {
          self._realm.add(entities)
          observer.onNext(true)
          observer.onCompleted()
        }
      } catch {
        observer.onError(DatabaseError.requestFailed)
      }
      return Disposables.create()
    }
  }
  
  public func deleteFromLocal(id: Int) -> Observable<Bool> {
    return Observable<Bool>.create { observer in
      do {
        let dataMovie = self._realm.objects(ObjMovie.self)
          .filter("id = %@", id).first
        if dataMovie == nil {
          observer.onNext(true)
          observer.onCompleted()
        } else {
          try self._realm.write {
            self._realm.delete(dataMovie!)
            observer.onNext(true)
            observer.onCompleted()
          }
        }
      } catch {
        observer.onError(DatabaseError.requestFailed)
      }
      return Disposables.create()
    }
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

