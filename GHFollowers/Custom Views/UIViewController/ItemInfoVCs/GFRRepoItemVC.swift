//
//  GFRRepoItemVC.swift
//  GHFollowers
//
//  Created by Ahmed on 8/17/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class GFRRepoItemVC: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems(){
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
}
 
