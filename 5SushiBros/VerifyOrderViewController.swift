//
//  ValidateOrderViewController.swift
//  5SushiBros
//
//  Created by Alex Andrews on 4/13/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit
import MessageUI
import CoreData

class VerifyOrderViewController: UIViewController, MFMessageComposeViewControllerDelegate {

    var ordererName = ""
    var ordererAddress = ""
    
    var order = Order()
    let nameTextField = UITextField()
    let addressTextField = UITextField()
    let orderTextView = UITextView()
    let orderButton = UIButton(type: .System)
    let textFieldHeight: CGFloat = 40
    let textFieldWidth: CGFloat = 250
    let buttonWidth: CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.ordererName != "" {
            self.nameTextField.text = self.ordererName
        }
        if self.ordererAddress != "" {
            self.addressTextField.text = self.ordererAddress
        }
        self.layoutOrderView()
        
        let scrollView = UIScrollView(frame: self.view.bounds)
        
        self.view.backgroundColor = UIColor(red: 27/255, green: 154/255, blue: 247/255, alpha: 1)
    
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(addressTextField)
        scrollView.addSubview(orderTextView)
        scrollView.addSubview(orderButton)
        scrollView.backgroundColor = UIColor(red: 27/255, green: 154/255, blue: 247/255, alpha: 1)
        scrollView.autoresizingMask = .FlexibleWidth
        let size = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height + 250)
        scrollView.contentSize = size
        
        self.view.addSubview(scrollView)
        
//        populateNameFieldIfExists()
//        populateAddressFieldIfExists()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.layoutOrderView()
        self.prepareOrder()
        self.orderTextView.text = self.order.customerOrderDescription()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        self.layoutOrderView()
        print(UIDevice.currentDevice().orientation)
    }
    
    func layoutOrderView() {
        
        let viewWidth = self.view.bounds.width
//        var viewHeight = self.view.bounds.height
        
        // set up the name field
        self.nameTextField.frame = CGRect(x: (viewWidth - textFieldWidth) / 2, y: 64, width: textFieldWidth, height: textFieldHeight)
        self.nameTextField.layoutMargins = UIEdgeInsets(top: 64, left: (viewWidth - textFieldWidth) / 2, bottom: 0, right: (viewWidth - textFieldWidth) / 2)
        self.nameTextField.placeholder = " Name"
        self.nameTextField.backgroundColor = .whiteColor()
        self.nameTextField.layer.cornerRadius = 3

        // set up the address field
        self.addressTextField.frame = CGRect(x: (viewWidth - textFieldWidth) / 2, y: 130, width: textFieldWidth, height: textFieldHeight)
        self.addressTextField.layoutMargins = UIEdgeInsets(top: 64, left: (viewWidth - textFieldWidth) / 2, bottom: 0, right: (viewWidth - textFieldWidth) / 2)
        self.addressTextField.placeholder = " Address"
        self.addressTextField.backgroundColor = .whiteColor()
        self.addressTextField.layer.cornerRadius = 3

        // set up the order text view
        self.orderTextView.frame = CGRect(x: (viewWidth - textFieldWidth) / 2, y: 210, width: textFieldWidth, height: 200)
        self.orderTextView.layoutMargins = UIEdgeInsets(top: 64, left: (viewWidth - textFieldWidth) / 2, bottom: 0, right: (viewWidth - textFieldWidth) / 2)
        self.orderTextView.backgroundColor = .whiteColor()
        self.orderTextView.editable = false
        self.orderTextView.layer.cornerRadius = 3
//        self.orderTextView.sizeToFit()
        
        // set up the order button
        self.orderButton.frame = CGRect(x: (viewWidth - buttonWidth) / 2, y: 450, width: buttonWidth, height: 40)
        self.orderButton.layoutMargins = UIEdgeInsets(top: 64, left: (viewWidth - buttonWidth) / 2, bottom: 40, right: (viewWidth - buttonWidth) / 2)
        self.orderButton.setTitle("Order", forState: .Normal)
        self.orderButton.addTarget(self, action: #selector(self.orderButtonPressed(_:)), forControlEvents: .TouchUpInside)
        self.orderButton.backgroundColor = .whiteColor()
        self.orderButton.layer.cornerRadius = 3
    }
    
    func orderButtonPressed(sender: UIButton) {
        print("order button pressed")
        
        saveNameAndAddressToCoreData()
        presentMessageController()
    }
    
    func saveNameAndAddressToCoreData() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // save name and address to CoreData
        let ordererEntityDescription = NSEntityDescription.entityForName("Orderer", inManagedObjectContext: managedContext)
        let ordererEntity = NSManagedObject(entity: ordererEntityDescription!, insertIntoManagedObjectContext: managedContext)
        ordererEntity.setValue(self.nameTextField.text, forKey: "name")
        ordererEntity.setValue(self.addressTextField.text, forKey: "address")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func presentMessageController() {
        let sendOrderViewController = MFMessageComposeViewController()
        sendOrderViewController.body = self.order.sushiOrderDescription()
        sendOrderViewController.recipients = ["3038150163"]
        sendOrderViewController.messageComposeDelegate = self
        self.presentViewController(sendOrderViewController, animated: true, completion: nil)
    }
    
    func populateNameFieldIfExists() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        var coreDataNameField = NSManagedObject()
        let fetchRequest = NSFetchRequest(entityName: "Name")
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            if results.count > 0 {
                coreDataNameField = results[0] as! NSManagedObject
                
                if let name = coreDataNameField.valueForKey("name") as? String {
                    self.nameTextField.text = name
                }
            } else {
                print("No name saved")
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

    }
    
    func populateAddressFieldIfExists() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareOrder() {
        var orderItems = [(Int, MenuItem)]()
        var totalPrice: Double = 0
        for subMenu in SushiMenu.sharedInstance.sushiMenu {
            for menuItem in subMenu {
                if menuItem.orderQuantity > 0 {
                    orderItems.append((menuItem.orderQuantity, menuItem))
                    totalPrice += menuItem.menuItemPrice * Double(menuItem.orderQuantity)
                }
            }
        }
        self.order = Order(name: self.nameTextField.text!, address: self.addressTextField.text!, items: orderItems, price: totalPrice)
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        switch (result) {
        case MessageComposeResultCancelled:
            print("Order was cancelled")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultFailed:
            print("Order send failed")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultSent:
            print("Order was sent")
            let orderCompleteViewController = OrderCompleteViewController()
            self.dismissViewControllerAnimated(true, completion: nil)
            self.presentViewController(orderCompleteViewController, animated: true, completion: nil)
        default:
            break;
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
