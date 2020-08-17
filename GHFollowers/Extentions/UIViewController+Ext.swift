//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Ahmed on 8/13/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let aletVC                      = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            aletVC.modalPresentationStyle   = .overFullScreen
            aletVC.modalTransitionStyle     = .crossDissolve
            self.present(aletVC, animated: true )
        }
    }
    
    func showLodingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        UIView.animate(withDuration: 0.25, animations: { containerView.alpha = 0.8 })
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmtyStateView(with message: String, in view: UIView) {
        let emptyView = GFEmptyStateView(message: message)
        emptyView.frame = view.frame
        view.addSubview(emptyView)
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
