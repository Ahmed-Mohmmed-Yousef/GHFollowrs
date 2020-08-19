//
//  FavoritesListVC.swift
//  GHFollowers
//
//  Created by Ahmed on 7/24/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class FavoritesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
        
        PersistenceManager.retrieveFavorites { (result) in
            switch result {
                
            case .success(let favorites):
                print(favorites)
            case .failure(_):
                break
            }
        }
    }
    

}
