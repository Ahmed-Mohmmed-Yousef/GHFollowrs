//
//  MainTabBarController.swift
//  GHFollowers
//
//  Created by Ahmed on 7/24/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()

    }
    
    fileprivate func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    fileprivate func createFavoritesListNC() -> UINavigationController {
        let favoritesVC = FavoritesListVC()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    fileprivate func setupTabBar() {
        tabBar.tintColor = .systemGreen
        viewControllers = [createSearchNC(),
                           createFavoritesListNC()]
    }
    

}
