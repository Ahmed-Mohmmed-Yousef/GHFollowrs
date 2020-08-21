//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Ahmed on 8/15/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {
    
    let headerView          = UIView()
    let itemViewOne         = UIView()
    let itemViewTwo         = UIView()
    let dateLabel           = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var follower: Follower!
    weak var delegate: FolloweListVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUser()
    }
    
    private func configureViewController(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismisdVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func getUser(){
        showLodingView()
        NetworkManager.shared.getUserInfo(for: follower.login) {[weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElement(with: user) }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    private func configureUIElement(with user: User) {
        let repoItemVC          = GFRRepoItemVC(user: user)
        repoItemVC.delegate     = self
        let followerItemVC      = GFFolloweItemVC(user: user)
        followerItemVC.delegate = self
         
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = " Github Since \(user.createdAt.convertToMonthYearFormate())"
    }
    
    private func layoutUI(){
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc private func dismisdVC(){
        dismiss(animated: true, completion: nil)
    }


}


extension UserInfoVC: UserInfoVCDelegate {
    
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentAlertOnMainThread(title: "Invalid Url", message: "the url that attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentAlertOnMainThread(title: "No Followers", message: "this user has no followers. what a shame 😞.", buttonTitle: "Ok")
            return
        }
        delegate.didRequestFollower(for: user.login)
        dismisdVC()
    }
    
    
}
