//
//  FolloweListVC.swift
//  GHFollowers
//
//  Created by Ahmed on 8/12/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

protocol FolloweListVCDelegate: class {
    func didRequestFollower(for username: String)
}

class FolloweListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    var filterdFollowers: [Follower] = []
    var isSearching = false
    var page = 1
    var hasMoreFollowers = true
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        cofigureCollectionView()
        getFollowers(userrname: username, page: page)
        
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    fileprivate func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    fileprivate func cofigureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    fileprivate func configureSearchController(){
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.delegate                     = self
        searchController.searchBar.placeholder                  = "Search for username"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
    }
    
    
    fileprivate func getFollowers(userrname: String, page: Int){
        showLodingView()
        NetworkManager.shared.getFollowers(for: userrname, page: page) {[weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let nfollowers):
                if nfollowers.count < 100 {  self.hasMoreFollowers = false }
                self.followers.append(contentsOf: nfollowers)
                self.updateData(on: self.followers)
                if self.followers.isEmpty {
                    let message = "This user dont has any followers, Go to follow them 🙂."
                    DispatchQueue.main.async {
                        self.showEmtyStateView(with: message, in: self.view)
                        return
                    }
                }
                
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    fileprivate func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    fileprivate func updateData(on follower: [Follower]){
        var  snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(follower)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
    
}


extension FolloweListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            print("Page: ", page)
            getFollowers(userrname: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray     = isSearching ? filterdFollowers : followers
        let follower        = activeArray[indexPath.item]
        
        let destVC          = UserInfoVC()
        destVC.delegate     = self
        destVC.follower     = follower
        let navController   = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
        
    }
    
    @objc func addButtonTapped(){
        print("Add")
    }
}

extension FolloweListVC: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching      = true
        filterdFollowers = followers.filter{$0.login.lowercased().contains(filter.lowercased())}
        self.updateData(on: filterdFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        self.updateData(on: followers)
    }
}


extension FolloweListVC: FolloweListVCDelegate {
    func didRequestFollower(for username: String) {
        self.username       = username
        title               = username
        page                = 1
        hasMoreFollowers    = true
        followers.removeAll()
        filterdFollowers.removeAll()
        
//        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(userrname: username, page: page)
    }
}
