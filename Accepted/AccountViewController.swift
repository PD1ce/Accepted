//
//  AccountViewController.swift
//  santasWorkshop
//
//  Created by Philip Deisinger on 1/23/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit
import CoreData

class AccountViewController: UIViewController {
    
    var username:String!
    var password:String!
    var user:NSManagedObject!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Account"
        username = user.valueForKey("username") as String?
        welcomeLabel.text = "Welcome, \(username)!"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func mySchoolsTapped(sender: AnyObject) {
        
        let mySchoolsViewController = storyboard?.instantiateViewControllerWithIdentifier("MySchoolsViewController") as MySchoolsViewController
        mySchoolsViewController.user = user
        navigationController?.pushViewController(mySchoolsViewController, animated: true)
        //performSegueWithIdentifier("mySchoolsSegue", sender: nil)
    }
    
    @IBAction func schoolSearchTapped(sender: AnyObject) {
        let schoolMapViewController = storyboard?.instantiateViewControllerWithIdentifier("SchoolMapViewController") as SchoolMapViewController
        schoolMapViewController.user = user
        navigationController?.pushViewController(schoolMapViewController, animated: true)
    }
}