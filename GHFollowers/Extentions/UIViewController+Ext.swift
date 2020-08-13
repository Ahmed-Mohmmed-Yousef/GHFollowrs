//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Ahmed on 8/13/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let aletVC                      = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            aletVC.modalPresentationStyle   = .overFullScreen
            aletVC.modalTransitionStyle     = .crossDissolve
            self.present(aletVC, animated: true )
        }
    }
}
