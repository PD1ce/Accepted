//
//  AccountViewController.swift
//  santasWorkshop
//
//  Created by Philip Deisinger on 1/23/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    var username:String!
    var password:String!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel.text = "Welcome, \(username)!"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
}