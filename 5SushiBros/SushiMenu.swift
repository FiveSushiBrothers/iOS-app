//
//  Menu.swift
//  5SushiBros
//
//  Created by Alex Andrews on 4/13/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation
import UIKit

class SushiMenu {
    static let sharedInstance = SushiMenu()
    
    var sushiMenu: [[MenuItem]]
    
    init() {
        let LilBro = MenuItem(imageView: UIImageView(image: UIImage(named: "placeHolder1")), name: "Lil Bro", price: 7, description: "fried salmon, cream cheese, zing sauce", quantity: 0)
        let Cali = MenuItem(imageView: UIImageView(image: UIImage(named: "placeHolder2")), name: "Cali", price: 7, description: "avocado, crab, cucumber", quantity: 0)
        let LoudBrother = MenuItem(imageView: UIImageView(image: UIImage(named: "placeHolder3")), name: "Loud Brother", price: 7, description: "tempura shrimp, avocado, chives", quantity: 0)
        let BandManager = MenuItem(imageView: UIImageView(image: UIImage(named: "placeHolder4")), name: "Band Manager", price: 8, description: "fried cali roll, cream cheese, sriracha, chives", quantity: 0)
        let DylanFromVegas = MenuItem(imageView: UIImageView(image: UIImage(named: "placeHolder5")), name: "Dylan From Vegas", price: 8, description: "fried salmon, cream cheese, avocado, crab", quantity: 0)
        let Bandies = MenuItem(imageView: UIImageView(image: UIImage(named: "placeHolder1")), name: "Bandies", price: 8, description: "marinated tempura shrimp", quantity: 0)
        let AngryBro = MenuItem(imageView: UIImageView(image: UIImage(named: "placeHolder2")), name: "Angry Bro", price: 9, description: "layered w/ tuna, black caviar, shrimp, avocado", quantity: 0)
        let TigerMom = MenuItem(imageView: UIImageView(image: UIImage(named: "placeHolder3")), name: "Tiger Mom", price: 9, description: "layered w/ sea bass, salmon, sweet chili, spicy tuna, shrimp", quantity: 0)
        let HotMexicanGirlfriend = MenuItem(imageView: UIImageView(image: UIImage(named: "placeHolder4")), name: "Hot Mexican Girlfriend", price: 9, description: "salmon, jalapeño caviar, shrimp, avocado, jalapeño", quantity: 0)
        
        let lowPriceRolls = [ LilBro, Cali, LoudBrother, MenuItem() ]
        let medPriceRolls = [ BandManager, DylanFromVegas, Bandies, MenuItem() ]
        let highPriceRolls = [ AngryBro, TigerMom, HotMexicanGirlfriend, MenuItem() ]
        sushiMenu = [ lowPriceRolls, medPriceRolls, highPriceRolls ]
    }
    
    
}

class MenuItem {
    let menuItemImageView: UIImageView
    let menuItemName: String
    let menuItemPrice: Double
    let menuItemDescription: String
    let menuItem: Bool
    var orderQuantity: Int
    var displayDescription: Bool
    var numberOfDescriptionLines: Int
    
    init (imageView: UIImageView, name: String, price: Double, description: String, quantity: Int) {
        menuItemImageView = imageView
        menuItemName = name
        menuItemPrice = price
        menuItemDescription = description
        orderQuantity = quantity
        menuItem = true
        displayDescription = false
        numberOfDescriptionLines = 1
    }
    
    init() {
        menuItemImageView = UIImageView(image: UIImage(named: "transparent"))
        menuItemImageView.alpha = 1
        menuItemName = ""
        menuItemPrice = 0
        menuItemDescription = ""
        orderQuantity = 0
        menuItem = false
        displayDescription = false
        numberOfDescriptionLines = 1
    }
    
}