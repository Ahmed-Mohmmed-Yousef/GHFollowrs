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
    
    func getFollowers(for username: String, page: Int, completion: @escaping([Follower]?, String?) -> Void){
        let endPoint = baseUrl + "\(username)/followers?per_page=100$page=\(page)"
        guard let url = URL(string: endPoint) else {
            completion(nil, "this username created an invalid request. please, try agan.")
            print("url")
            return
        }
         
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(nil, "Unable to complete your request. Please, check your network.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, "Invalid response from server. Please, try again.")
                return
            }
            
            guard let data = data else {
                completion(nil, "The data recived from server was invalid, Please, try again")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(followers, nil )
            } catch {
                completion(nil, "The data cant be decoded")
            }
            
        }
        
        task.resume()
    }
}
