
//
//  MenuItemDescriptionCell.swift
//  5SushiBros
//
//  Created by Alex Andrews on 4/18/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit

class MenuItemDescriptionCell: UICollectionViewCell {

    let menuItemDescriptionTextView: UITextView = UITextView()
    let setMenuItemAmountView: UIView = UIView()
    var cellEdge: CGFloat = 0
    var collectionViewCellsEdge: CGFloat = 0
    var selectedItemIndexPath = NSIndexPath()
    var cellContentView = UIView()
    let arrowIndicatorHeight: CGFloat = 10
    let menuItemLabelHeight: CGFloat = 15
    let shortMenuItemDescriptionHeight: CGFloat = 20
    let longMenuItemDescriptionHeight: CGFloat = 40

    func configureSubViews(indexPath: NSIndexPath, cellEdge: CGFloat, collectionViewCellsEdge: CGFloat) {
        
        print(self.contentView.frame.height)
        
        self.contentView.backgroundColor = UIColor.greenColor()

        self.selectedItemIndexPath = indexPath
        self.cellEdge = cellEdge

        self.collectionViewCellsEdge = collectionViewCellsEdge
        
        for subView in self.cellContentView.subviews {
            subView.removeFromSuperview()
        }
        
        self.cellContentView.frame = CGRect(x: 0, y: arrowIndicatorHeight / 2, width: self.collectionViewCellsEdge, height: (self.cellEdge - (arrowIndicatorHeight / 2)))
        print("Height:", self.cellContentView.frame.height)
        self.cellContentView.backgroundColor = UIColor.whiteColor()
        self.cellContentView.layer.cornerRadius = 5
        self.contentView.addSubview(self.cellContentView)
        
        configureSelectedIndicatorArrow()
        configureTitleView()
        configureDescriptionView()
        configureSetAmountView()
    }
    
    func configureSelectedIndicatorArrow() {
        
        for subView in self.contentView.subviews {
            if subView.accessibilityIdentifier == "ArrowIndicator" {
                subView.removeFromSuperview()
            }
        }
        
        let arrowIndicator = UIView()
        if selectedItemIndexPath.row == 0 {
             arrowIndicator.frame = CGRect(x: self.cellEdge / 2, y: 0, width: arrowIndicatorHeight, height: arrowIndicatorHeight)
        } else if selectedItemIndexPath.row == 1 {
            arrowIndicator.frame = CGRect(x: self.collectionViewCellsEdge / 2, y: 0, width: arrowIndicatorHeight, height: arrowIndicatorHeight)
        } else if selectedItemIndexPath.row == 2 {
            arrowIndicator.frame = CGRect(x: self.collectionViewCellsEdge - (self.cellEdge / 2), y: 0, width: arrowIndicatorHeight, height: arrowIndicatorHeight)
        }
        
        arrowIndicator.backgroundColor = UIColor.whiteColor()
        arrowIndicator.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
        arrowIndicator.accessibilityIdentifier = "ArrowIndicator"
        self.contentView.addSubview(arrowIndicator)
        self.contentView.sendSubviewToBack(arrowIndicator)
    }
    
    func configureTitleView() {
        
        let itemAtIndex = SushiMenu.sharedInstance.sushiMenu[selectedItemIndexPath.section][selectedItemIndexPath.row]
        let menuItemLabel = UILabel()
        menuItemLabel.text = "$" + String(Int(itemAtIndex.menuItemPrice)) + " " + itemAtIndex.menuItemName.uppercaseString
        menuItemLabel.frame = CGRect(x: 0, y: 5, width: self.collectionViewCellsEdge, height: self.cellEdge / 5)
        menuItemLabel.backgroundColor = UIColor.blueColor()
        menuItemLabel.adjustsFontSizeToFitWidth = true
        
        if selectedItemIndexPath.row == 0 {
            menuItemLabel.textAlignment = .Left
        } else if selectedItemIndexPath.row == 1 {
            menuItemLabel.textAlignment = .Center
        } else if selectedItemIndexPath.row == 2 {
            menuItemLabel.textAlignment = .Right
        }
        menuItemLabel.userInteractionEnabled = false
        
        self.cellContentView.addSubview(menuItemLabel)
    }
    
    func configureDescriptionView() {
        let itemAtIndex = SushiMenu.sharedInstance.sushiMenu[selectedItemIndexPath.section][selectedItemIndexPath.row]
        let menuItemDescription = UITextView()
        
        menuItemDescription.backgroundColor = UIColor.clearColor()
        menuItemDescription.text = itemAtIndex.menuItemDescription
        menuItemDescription.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        menuItemDescription.font = UIFont(name: (menuItemDescription.font?.fontName)!, size: (menuItemDescription.font?.pointSize)! + 2)
        
        if Double(menuItemDescription.text.characters.count) * 7.34  >= Double(self.collectionViewCellsEdge) {
            menuItemDescription.frame = CGRect(x: 0, y: self.menuItemLabelHeight + 5, width: self.collectionViewCellsEdge, height: self.longMenuItemDescriptionHeight)
        } else {
            menuItemDescription.frame = CGRect(x: 0, y: self.menuItemLabelHeight + 5, width: self.collectionViewCellsEdge, height: self.shortMenuItemDescriptionHeight)
        }
        
        if selectedItemIndexPath.row == 0 {
            menuItemDescription.textAlignment = .Left
        } else if selectedItemIndexPath.row == 1 {
            menuItemDescription.textAlignment = .Center
        } else if selectedItemIndexPath.row == 2 {
            menuItemDescription.textAlignment = .Right
        }
        menuItemDescription.userInteractionEnabled = false
        
        self.cellContentView.addSubview(menuItemDescription)
        
    }
    
    func configureDescriptionViewOld() {
        
        var description = ""
        let itemAtIndex = SushiMenu.sharedInstance.sushiMenu[selectedItemIndexPath.section][selectedItemIndexPath.row]
        let menuItemDescription = UITextView()
        menuItemDescription.layer.cornerRadius = 5
        menuItemDescription.frame = CGRect(x: 0, y: 5, width: self.collectionViewCellsEdge, height: (self.cellEdge / 3) * 2)
        
        
        description = "$" + String(Int(itemAtIndex.menuItemPrice)) + " " + itemAtIndex.menuItemName.uppercaseString + "\n" + itemAtIndex.menuItemDescription
        menuItemDescription.text = description
        
        if selectedItemIndexPath.row == 0 {
            menuItemDescription.textAlignment = .Left
        } else if selectedItemIndexPath.row == 1 {
            menuItemDescription.textAlignment = .Center
        } else if selectedItemIndexPath.row == 2 {
            menuItemDescription.textAlignment = .Right
        }
        menuItemDescription.userInteractionEnabled = false
        
        self.contentView.addSubview(menuItemDescription)
    }
    
    func configureSetAmountView() {
        
        for subView in self.cellContentView.subviews {
            for subSubView in subView.subviews {
                if subSubView.accessibilityIdentifier == "NumberOfItemsTextField" {
                    subSubView.removeFromSuperview()
                }
            }
        }
        
        let plusOneItem = UIButton()
        let minusOneItem = UIButton()
        let numberOfItems = UITextField()
        
        minusOneItem.setImage(UIImage(named: "minus"), forState: .Normal)
//        minusOneItem.imageView?.contentMode = .ScaleAspectFit
        minusOneItem.addTarget(self, action: #selector(self.minusOneItemPushed(_:)), forControlEvents: .TouchUpInside)
//        minusOneItem.addTarget(self, action: #selector(self.minusOneItemPushedAndHeld(_:)), forControlEvents: .)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.minusOneItemPushedAndHeld(_:)))
        minusOneItem.addGestureRecognizer(longPressGesture)
        minusOneItem.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        plusOneItem.setImage(UIImage(named: "plus"), forState: .Normal)
        plusOneItem.addTarget(self, action: #selector(self.plusOneItemPushed(_:)), forControlEvents: .TouchUpInside)
        plusOneItem.imageView?.contentMode = .ScaleAspectFit
        plusOneItem.frame = CGRect(x: 60, y: 0, width: 25, height: 25)
        
        numberOfItems.text = String(SushiMenu.sharedInstance.sushiMenu[self.selectedItemIndexPath.section][self.selectedItemIndexPath.row].orderQuantity)
        numberOfItems.frame = CGRect(x: 30, y: 0, width: 20, height: 25)
        numberOfItems.adjustsFontSizeToFitWidth = true
        numberOfItems.userInteractionEnabled = false
        numberOfItems.textAlignment = .Center
        numberOfItems.accessibilityIdentifier = "NumberOfItemsTextField"
        
        let setAmountView = UIView()
        let setAmountViewX = (self.collectionViewCellsEdge / 2) - (self.cellEdge / 2)
        let setAmountViewY = (self.cellEdge / 3) * 2
        let setAmountWidth = self.cellEdge
        let setAmountHeight = self.cellEdge / 3
        
        setAmountView.frame = CGRect(x: setAmountViewX, y: setAmountViewY, width: setAmountWidth, height: setAmountHeight)
        
        setAmountView.addSubview(plusOneItem)
        setAmountView.addSubview(minusOneItem)
        setAmountView.addSubview(numberOfItems)
        
        self.cellContentView.addSubview(setAmountView)
    }
    
    func hideSubViews() {
        
        for subView in self.contentView.subviews {
            subView.removeFromSuperview()
        }
    }
    
    func plusOneItemPushed(sender: UIButton) {
        print("plus one")
        SushiMenu.sharedInstance.sushiMenu[self.selectedItemIndexPath.section][self.selectedItemIndexPath.row].orderQuantity += 1
        self.configureSetAmountView()
        
        if let menuCollectionView = self.superview as? UICollectionView {
            menuCollectionView.reloadItemsAtIndexPaths([self.selectedItemIndexPath])
        }
    }
    
    func minusOneItemPushed(sender: UIButton) {
        print("minus one")
        if SushiMenu.sharedInstance.sushiMenu[self.selectedItemIndexPath.section][self.selectedItemIndexPath.row].orderQuantity > 0 {
            SushiMenu.sharedInstance.sushiMenu[self.selectedItemIndexPath.section][self.selectedItemIndexPath.row].orderQuantity -= 1
        }
        self.configureSetAmountView()
        if let menuCollectionView = self.superview as? UICollectionView {
            menuCollectionView.reloadItemsAtIndexPaths([self.selectedItemIndexPath])
        }
    }
    
    func minusOneItemPushedAndHeld(sender: UIButton) {
        print("tapped and held")
        if SushiMenu.sharedInstance.sushiMenu[self.selectedItemIndexPath.section][self.selectedItemIndexPath.row].orderQuantity > 0 {
            SushiMenu.sharedInstance.sushiMenu[self.selectedItemIndexPath.section][self.selectedItemIndexPath.row].orderQuantity = 0
        }
        self.configureSetAmountView()
        if let menuCollectionView = self.superview as? UICollectionView {
            menuCollectionView.reloadItemsAtIndexPaths([self.selectedItemIndexPath])
        }
    }
}
