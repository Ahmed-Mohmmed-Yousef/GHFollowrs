//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Ahmed on 8/13/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImage = "avatar"

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func configure(){
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = UIImage(named: placeholderImage)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
