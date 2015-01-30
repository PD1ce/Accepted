//
//  HomeViewController.swift
//  santasWorkshop
//
//  Created by Philip Deisinger on 1/23/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    var users:[NSManagedObject]?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: "User")
        var error:NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            users = results
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginTapped(sender: AnyObject) {
        //Check for username/Password
        for user in users! {
            if user.valueForKey("username") as NSString == usernameTextField.text && user.valueForKey("password") as NSString == passwordTextField.text {
                    let accountViewController = storyboard?.instantiateViewControllerWithIdentifier("AccountViewController") as AccountViewController
                    accountViewController.username = usernameTextField.text?
                    accountViewController.password = passwordTextField.text?
                    
                    let navController = UINavigationController(rootViewController: accountViewController)
                    presentViewController(navController, animated: true, completion: nil)
                    break
            }
        }
    
    

        
        
//        
//        
//        let accountViewController = storyboard?.instantiateViewControllerWithIdentifier("AccountViewController") as AccountViewController
//        accountViewController.username = usernameTextField.text?
//        accountViewController.password = passwordTextField.text?
//        
//        let navController = UINavigationController(rootViewController: accountViewController)
//        presentViewController(navController, animated: true, completion: nil)
    
        
        
    }
    
    @IBAction func createAccountTapped(sender: AnyObject) {
        let createAccountViewController = storyboard?.instantiateViewControllerWithIdentifier("CreateAccountViewController") as CreateAccountViewController
        
        createAccountViewController.users = users!
        
        presentViewController(createAccountViewController, animated: true, completion: nil)
    }
   
    
    @IBAction func close(segue:UIStoryboardSegue) {
        println("Close")
    }
    
    
    
}