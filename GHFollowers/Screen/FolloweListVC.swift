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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
     
    

   

}
