//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Ahmed on 8/15/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {

    let messageLabel    = GFTitleLable(textAlignment: .center, fontSize: 28)
    let logoImageView   = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    private func configure(){
        backgroundColor = .systemBackground
        addSubview(messageLabel)
        addSubview(logoImageView)
        
        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .secondaryLabel
        
        logoImageView.contentMode   = .scaleAspectFit
        logoImageView.image         = #imageLiteral(resourceName: "avatar")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
//
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170)
        ])
    }
}
