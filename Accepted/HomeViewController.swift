//
//  ViewController.swift
//  santasWorkshop
//
//  Created by Philip Deisinger on 1/23/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginTapped(sender: AnyObject) {
        let accountViewController = storyboard?.instantiateViewControllerWithIdentifier("AccountViewController") as AccountViewController
        accountViewController.username = usernameTextField.text?
        accountViewController.password = passwordTextField.text?
        
        let navController = UINavigationController(rootViewController: accountViewController)
        presentViewController(navController, animated: true, completion: nil)
    }
    
    @IBAction func createAccountTapped(sender: AnyObject) {
        let createAccountViewController = storyboard?.instantiateViewControllerWithIdentifier("CreateAccountViewController") as CreateAccountViewController
        presentViewController(createAccountViewController, animated: true, completion: nil)
    }
   
    
    @IBAction func close(segue:UIStoryboardSegue) {
        println("Close")
    }
    
    
    
}