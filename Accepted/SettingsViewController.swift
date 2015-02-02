//
//  SettingsViewController.swift
//  Accepted
//
//  Created by Philip Deisinger on 2/2/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController : UIViewController {
    
    var user: User!
    var username: String!
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = user.username
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}