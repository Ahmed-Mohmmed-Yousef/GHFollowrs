//
//  FolloweListVC.swift
//  GHFollowers
//
//  Created by Ahmed on 8/12/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class FolloweListVC: UIViewController {
    
    var username: String!
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        cofigureCollectionView()
        getFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    fileprivate func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func cofigureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    fileprivate func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let avilableWidth: CGFloat      = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth: CGFloat          = avilableWidth / 3
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
    
    fileprivate func getFollowers(){
        NetworkManager.shared.getFollowers(for: username, page: 1) { (result) in
            switch result {
            case .success(let followers):
                print(followers)
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
}
