//
//  OrderCompleteViewController.swift
//  5SushiBros
//
//  Created by Alex Andrews on 4/13/16.
//  Copyright © 2016 Sneakywolf. All rights reserved.
//

import UIKit

class OrderCompleteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 27/255, green: 154/255, blue: 247/255, alpha: 1)
        let scooterImage = UIImage(named: "scooter-image")
        let scooterImageView = UIImageView(image: scooterImage)
        
        let returnToMenuButton = UIButton()
        returnToMenuButton.setTitle("Return to Sushi Menu", forState: .Normal)
        returnToMenuButton.frame = CGRect(x: (self.view.frame.width / 3) - (self.view.frame.width / 2), y: (self.view.frame.height / 3) * 2, width: self.view.frame.width, height: 40)
        returnToMenuButton.addTarget(self, action: #selector(self.returnToMenuButtonPressed(_:)), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(scooterImageView)
        self.view.addSubview(returnToMenuButton)
        
        scooterImageView.contentMode = .ScaleAspectFit
        scooterImageView.frame = CGRect(x: self.view.frame.width / 3, y: self.view.frame.height / 3, width: self.view.frame.width / 3, height: self.view.frame.height / 3)
        scooterImageView.center = self.view.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func returnToMenuButtonPressed(sender: UIButton) {
        print("pressed return button")
        SushiTabBarController.sharedInstance.initializeViewControllers()
        SushiTabBarController.sharedInstance.selectedIndex = 0
        self.dismissViewControllerAnimated(true, completion: nil)
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
