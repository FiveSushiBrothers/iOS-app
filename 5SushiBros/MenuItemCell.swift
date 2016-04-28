//
//  MenuItemCell.swift
//  5SushiBros
//
//  Created by Alex Andrews on 4/4/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit

class MenuItemCell: UICollectionViewCell {
    
    func configureSubViews(imageView: UIImageView, cellEdge: CGFloat) {
        self.contentView.addSubview(imageView)
//        self.menuItemImage.frame = CGRect(x: 0, y: 0, width: cellEdge, height: cellEdge)
//        self.menuItemImage.center = self.contentView.center
//        self.menuItemImage.contentMode = .ScaleAspectFit
//        
        imageView.frame = CGRect(x: 0, y: 0, width: cellEdge, height: cellEdge)
        imageView.center = self.contentView.center
        imageView.contentMode = .ScaleAspectFit
    }
    
    func addOrderQuantityBadge(quantity: Int) {
        
        let orderQuantityBadge = UITextField(frame: CGRect(x: self.contentView.bounds.width - 16, y: 0, width: 20, height: 20))
        orderQuantityBadge.accessibilityIdentifier = "OrderQuantityBadge"
        orderQuantityBadge.backgroundColor = UIColor.whiteColor()
        orderQuantityBadge.textAlignment = .Center
        orderQuantityBadge.allowsEditingTextAttributes = false
        orderQuantityBadge.layer.cornerRadius = 10
        orderQuantityBadge.text = String(quantity)
        orderQuantityBadge.adjustsFontSizeToFitWidth = true
        orderQuantityBadge.clipsToBounds = true
        orderQuantityBadge.font = UIFont(name: (orderQuantityBadge.font?.fontName)!, size: (orderQuantityBadge.font?.pointSize)! - 6)
        
        self.contentView.addSubview(orderQuantityBadge)
    }
    
    func removeOrderQuantityBadge() {
        
        for subView in self.contentView.subviews {
            if subView.accessibilityIdentifier == "OrderQuantityBadge" {
                subView.removeFromSuperview()
            }
        }
    }
}
