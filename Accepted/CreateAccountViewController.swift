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

    var users = [User]() //MODEL
    var username = String()
    var password = String()
    var parentVC:HomeViewController!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.secureTextEntry = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        errorLabel.text = ""
    }
    
    //////// This should be moved to the model ////////////
    func saveUser() -> Bool {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: managedContext)
        let user = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedContext) as User
        //User(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        

        
        user.username = username
        user.password = password
        
        println("User: \(user)")
        println("username: \(user.username)")
        
        //TEMP # of schools holder!////
        //user.setValue(0, forKey: "age")
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
            return false
        }
        users.append(user)
        return true
    }
    
    @IBAction func createAccountTapped(sender: AnyObject) {
        username = usernameTextField.text!
        password = passwordTextField.text!
        if saveUser() {
            parentVC.users = users
            println("parentVC.users: \(parentVC.users!)")
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            errorLabel.text = "Sorry, an error occured."
        }
        
    }
}