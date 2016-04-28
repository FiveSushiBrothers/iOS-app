//
//  ViewController.swift
//  5SushiBros
//
//  Created by Alex Andrews on 4/4/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var menuViewLabel = UILabel()
    var collectionView: UICollectionView!
    var collectionViewLayout: UICollectionViewFlowLayout!
    let menuItemIdentifier = "MenuItemCellReuseIvartifier"
    let descriptionItemIdentifier = "DescriptionItemCellReuseIdentifier"
    var selectedItemIndexPath = NSIndexPath(forRow: 0, inSection: 0)
    
    var viewHeight: CGFloat = 0
    var viewWidth: CGFloat = 0
    var menuItemCellEdge: CGFloat = 0
    var leftAndRightMargin: CGFloat = 0
    var inbetweenCellMargin: CGFloat = 0
    var collectionViewCellsEdge: CGFloat = 0
    var topAndBottomMargin: CGFloat = 0
    var descriptionLineHeight: CGFloat = 0
    
    
    let backgroundView = UIView()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionViewLayout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: self.collectionViewLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.registerClass(MenuItemCell.self, forCellWithReuseIdentifier: menuItemIdentifier)
        collectionView.registerClass(MenuItemDescriptionCell.self, forCellWithReuseIdentifier: descriptionItemIdentifier)
        
        collectionView.backgroundColor = UIColor(red: 27/255, green: 154/255, blue: 247/255, alpha: 1)
        collectionView.autoresizingMask = .FlexibleWidth

        self.view.addSubview(collectionView)
        
        self.layoutCollectionView()
        self.calculateCellDimensions()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.layoutCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func layoutCollectionView() {
        
        self.viewHeight = self.view.bounds.height
        self.viewWidth = self.view.bounds.width
        self.menuItemCellEdge = self.viewWidth / 4
        self.leftAndRightMargin = (self.viewWidth - (3 * self.menuItemCellEdge)) / 3
        self.inbetweenCellMargin = self.leftAndRightMargin / 2
        self.collectionViewCellsEdge = 3 * self.menuItemCellEdge + 2 * self.inbetweenCellMargin
        self.topAndBottomMargin = (viewHeight - self.collectionViewCellsEdge) / 2
    }
    
    func calculateCellDimensions() {
//        descriptionTitleHeight = self.menuItemCellEdge / 5
        self.descriptionLineHeight = self.menuItemCellEdge / 5
//        setAmountButtonSize = self.menuItemCellEdge / 4
//        orderQuantityBadgeSize = self.menuItemCellEdge / 4
//        numberOfItemsToOrder = self.
//        arrowIndicatorHeight =
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return SushiMenu.sharedInstance.sushiMenu.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SushiMenu.sharedInstance.sushiMenu[section].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let itemAtIndex = SushiMenu.sharedInstance.sushiMenu[indexPath.section][indexPath.row]
       
        // initialize non-displaying description cells as blank
        // initialize displaying description cells and configure
        if indexPath.row == 3 {

            let descriptionItemCell = collectionView.dequeueReusableCellWithReuseIdentifier(descriptionItemIdentifier, forIndexPath: selectedItemIndexPath) as! MenuItemDescriptionCell
        
            if itemAtIndex.displayDescription {
                // show all subviews
                descriptionItemCell.configureSubViews(self.selectedItemIndexPath, cellEdge: self.menuItemCellEdge, collectionViewCellsEdge: self.collectionViewCellsEdge)
            } else {
                // hide all subviews
                descriptionItemCell.hideSubViews()
            }
            return descriptionItemCell
        }
        // initialize menu item cells
        else {
            let menuItemCell = collectionView.dequeueReusableCellWithReuseIdentifier(menuItemIdentifier, forIndexPath: indexPath) as! MenuItemCell
            menuItemCell.configureSubViews(itemAtIndex.menuItemImageView, cellEdge: self.menuItemCellEdge)
            if itemAtIndex.orderQuantity > 0 {
                menuItemCell.addOrderQuantityBadge(itemAtIndex.orderQuantity)
            } else {
                menuItemCell.removeOrderQuantityBadge()
            }
            
            return menuItemCell
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        // if the item at indexPath is a menu item or if its a enabled or disabled description cell
        let itemAtIndexPath = SushiMenu.sharedInstance.sushiMenu[indexPath.section][indexPath.row]
        
        if itemAtIndexPath.menuItem {
            return CGSize(width: self.menuItemCellEdge, height: self.menuItemCellEdge)
        } else if itemAtIndexPath.displayDescription {
            
            if Double(SushiMenu.sharedInstance.sushiMenu[self.selectedItemIndexPath.section][self.selectedItemIndexPath.row].menuItemDescription.characters.count) * 7.34 >= Double(self.collectionViewCellsEdge) {
                itemAtIndexPath.numberOfDescriptionLines = 2
                return CGSize(width: self.collectionViewCellsEdge, height: self.menuItemCellEdge + self.descriptionLineHeight)
            }
            
            return CGSize(width: self.collectionViewCellsEdge, height: self.menuItemCellEdge)
        
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        // flag the appropriate description item to display the description
        // reload the cells to reconfigure
        
        if selectedItemIndexPath != indexPath {
            SushiMenu.sharedInstance.sushiMenu[self.selectedItemIndexPath.section][3].displayDescription = false
        }
        
        self.selectedItemIndexPath = indexPath
        SushiMenu.sharedInstance.sushiMenu[indexPath.section][3].displayDescription = true
        
        let descriptionCellIndexes = [indexPath, NSIndexPath(forRow: 3, inSection: 0), NSIndexPath(forRow: 3, inSection: 1), NSIndexPath(forRow: 3, inSection: 2)]
        
        self.collectionView.reloadItemsAtIndexPaths(descriptionCellIndexes)
    }
  
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        // this allows for smaller space between menu cells & description cells
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        return self.inbetweenCellMargin
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        // set the top section margin much larger than other sections
        if section == 0 {
            return UIEdgeInsets(top: self.topAndBottomMargin / 2, left: self.leftAndRightMargin, bottom: 0, right: self.leftAndRightMargin)
        } else {
            return UIEdgeInsets(top: self.inbetweenCellMargin, left: self.leftAndRightMargin, bottom: 0, right: self.leftAndRightMargin)
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        // don't allow selection of description cells
        if indexPath.row == 3 {
            return false
        } else {
            return true
        }
    }
}

