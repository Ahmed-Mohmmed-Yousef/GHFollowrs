//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Ahmed on 8/14/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

struct UIHelper {
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let avilableWidth: CGFloat      = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth: CGFloat          = avilableWidth / 3
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
}
