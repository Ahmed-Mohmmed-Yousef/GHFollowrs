//
//  GFFolloweItemVC.swift
//  GHFollowers
//
//  Created by Ahmed on 8/17/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

class GFFolloweItemVC: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .follower, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtomTapped() {
        delegate.didTapGetFollowers(for: self.user)
    }
}
