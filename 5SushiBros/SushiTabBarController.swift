//
//  SushiTabBarController.swift
//  5SushiBros
//
//  Created by Alex Andrews on 4/13/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit

class SushiTabBarController: UITabBarController {
    static let sharedInstance = SushiTabBarController()

    var ordererName = ""
    var ordererAddress = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func initializeViewControllers() {
        
        let menuItemsViewController = MenuViewController()
        menuItemsViewController.tabBarItem = UITabBarItem(title: "Menu", image: nil, selectedImage: nil)
        let verifyOrderViewController = VerifyOrderViewController()
        verifyOrderViewController.ordererName = self.ordererName
        verifyOrderViewController.ordererAddress = self.ordererAddress
        verifyOrderViewController.tabBarItem = UITabBarItem(title: "Order", image: UIImage(named: "scooter"), selectedImage: nil)
        
        self.viewControllers = [menuItemsViewController, verifyOrderViewController]
    }
}
