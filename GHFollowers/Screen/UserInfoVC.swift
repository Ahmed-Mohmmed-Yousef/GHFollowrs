//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Ahmed on 8/15/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var follower: Follower!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismisdVC))
        navigationItem.rightBarButtonItem = doneButton
        
        NetworkManager.shared.getUserInfo(for: follower.login) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    @objc private func dismisdVC(){
        dismiss(animated: true, completion: nil)
    }


}
