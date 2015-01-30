//
//  CreateAccountViewController.swift
//  santasWorkshop
//
//  Created by Philip Deisinger on 1/28/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit
import CoreData

class CreateAccountViewController: UIViewController {

    var users = [NSManagedObject]()
    var username = String()
    var password = String()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //////// This should be moved to the model ////////////
    func saveUser(user: User) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: managedContext)
        let user = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        user.setValue(username, forKey: "username")
        user.setValue(password, forKey: "password")
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
    }
    
    @IBAction func createAccountTapped(sender: AnyObject) {
        username = usernameTextField.text!
        password = passwordTextField.text!
        let newUser = User(username: username, password: password)
        saveUser(newUser)
    }
}