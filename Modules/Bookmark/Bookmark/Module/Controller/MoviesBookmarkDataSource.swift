//
//  MoviesLocaleDataSource.swift
//  Bookmark
//
//  Created by Budi Darmawan on 12/12/21.
//

import RealmSwift
import Core
import RxSwift
import CommonExt

public class MoviesBookmarkDataSource: LocaleDataSource {
  
  public typealias Request = String
  public typealias Response = Results<ObjMovie>
  
  private let _realm: Realm
  
  public init(realm: Realm) {
    _realm = realm
  }
  
  public func getBookmarkMovies(query: String?) -> Observable<Results<ObjMovie>> {
    return Observable<Results<ObjMovie>>.create { observer in
        do {
          try self._realm.write {
            
            let list = self._realm.objects(ObjMovie.self)
              .sorted(byKeyPath: "title", ascending: true)
            if query?.isEmpty == true {
              observer.onNext(list)
            } else {
              let filterList = list.filter("title contains[c] %@", query ?? "")
              observer.onNext(filterList)
            }
            observer.onCompleted()
          }
        } catch {
          observer.onError(DatabaseError.requestFailed)
        }
      return Disposables.create()
    }
  }
  
  public func getMovie(id: String) -> Observable<Results<ObjMovie>> {
    return Observable<Results<ObjMovie>>.create { observer in
        do {
          try self._realm.write {
            let result = self._realm.objects(ObjMovie.self)
              .filter("id = %@", Int(id) ?? 0)
            observer.onNext(result)
            observer.onCompleted()
          }
        } catch {
          observer.onError(DatabaseError.requestFailed)
        }
      return Disposables.create()
    }
  }
  
  public func addToLocal(entities: ObjMovie) -> Observable<Bool?> {
    return Observable<Bool?>.create { observer in
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
  
  public func deleteFromLocal(id: String) -> Observable<Bool?> {
    return Observable<Bool?>.create { observer in
      do {
        let dataMovie = self._realm.objects(ObjMovie.self)
          .filter("id = %@", Int(id) ?? 0).first
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
