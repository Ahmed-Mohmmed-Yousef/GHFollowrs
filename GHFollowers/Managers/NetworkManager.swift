//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Ahmed on 8/13/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com/users/"
    
    private init(){}
    
    func getFollowers(for username: String, page: Int, completion: @escaping(Result<[Follower], GFError>) -> Void){
        let endPoint = baseUrl + "\(username)/followers?per_page=100$page=\(page)"
        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUsername))
            print("url")
            return
        }
         
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
}
