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
    var user: User!
    var username = String()
    var password = String()
    var parentVC:HomeViewController!
    
    //Ugly, used to dismiss this as well
    var detailsUpdated: Bool!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsUpdated = false
        passwordTextField.secureTextEntry = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let details = detailsUpdated!
        if details {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        errorLabel.text = ""
    }
    
  
    
    @IBAction func createAccountTapped(sender: AnyObject) {
        username = usernameTextField.text!
        password = passwordTextField.text!
        
        //This is terrible and needs to be changed
        if username != "" && password != "" {
            if saveUser() {
                parentVC.users = users
                println("parentVC.users: \(parentVC.users!)")
                
                let createDetailsVC = storyboard?.instantiateViewControllerWithIdentifier("CreateDetailsViewContoller") as CreateDetailsViewContoller
                createDetailsVC.user = self.user
                createDetailsVC.parentVC = self
                presentViewController(createDetailsVC, animated: true, completion: nil)
                //dismissViewControllerAnimated(true, completion: nil)
            } else {
                errorLabel.text = "Sorry, an error occured."
            }
        } else {
            errorLabel.text = "Please enter a username and password"
        }
        
        
    }
    
    //////// This should be moved to the model ////////////
    func saveUser() -> Bool {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        //        let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: managedContext)
        let user = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedContext) as User
        //User(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        
        self.user = user
        self.user.username = username
        self.user.password = password
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
}