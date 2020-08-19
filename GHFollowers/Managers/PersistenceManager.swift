//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Ahmed on 8/18/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation

enum PersistanceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defults = UserDefaults.standard
    
    enum Key {
        static let favorites = "favorites"
    }
    
    static func update(favorite: Follower, actionType: PersistanceActionType, completion: @escaping(GFError?) -> Void) {
        retrieveFavorites { (result) in
            switch result {
                
            case .success(let favorites):
                var retrievedFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completion(.alreadyInFavorite)
                        return
                    }
                    retrievedFavorites.append(favorite)
                case .remove:
                    retrievedFavorites.removeAll(where: {$0.login == favorite.login})
                }
                completion(save(favorites: retrievedFavorites))
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    static func retrieveFavorites(completion: @escaping(Result<[Follower], GFError>) -> Void){
        guard let favoritesData = defults.object(forKey: Key.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encoderFavorites = try encoder.encode(favorites)
            defults.set(encoderFavorites, forKey: Key.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
