//
//  File.swift
//  5SushiBros
//
//  Created by Alex Andrews on 4/14/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import Foundation

class Order {
    
    let orderName: String
    let orderAddress: String
    let orderItems: [(Int, MenuItem)]
    let totalPrice: Double
    
    init(name: String, address: String, items: [(Int, MenuItem)], price: Double) {
        orderName = name
        orderAddress = address
        orderItems = items
        totalPrice = price
    }
    init() {
        orderName = ""
        orderAddress = ""
        orderItems = [(0, MenuItem())]
        totalPrice = 0
    }
    
    func customerOrderDescription() -> String {
        var orderDescription = ""
        for item in self.orderItems {
            orderDescription += String(item.0) + " " + item.1.menuItemName + "\n"
        }
        orderDescription += "\nTotal: $" + String(Int(self.totalPrice))
        
        return orderDescription
    }
    
    func sushiOrderDescription() -> String{
        var orderDescription = orderName + "\n" + orderAddress + "\n"
        for item in self.orderItems {
            orderDescription += String(item.0) + " " + item.1.menuItemName + "\n"
        }
        orderDescription += "Total: $" + String(Int(self.totalPrice))
        
        print("ORDERDESCRIPTION\n" + orderDescription)
        return orderDescription
    }
}