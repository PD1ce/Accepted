//
//  UpdateUserViewController.swift
//  Accepted
//
//  Created by Philip Deisinger on 2/3/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UpdateUserViewController : UIViewController {
    
    var user: User!
    var parent: SettingsViewController!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var majorsTextField: UITextField!
    @IBOutlet weak var dreamSchoolTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    //@IBOutlet weak var ageTextField: UITextField!
    //Make age field a clicker or w/e
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveSettingsTapped(sender: AnyObject) {
        
        if !usernameTextField.text.isEmpty {
            println("usernameTextfield was not empty")
            user.username = usernameTextField.text
        }
        if !passwordTextField.text.isEmpty { user.password = passwordTextField.text }
        if !firstNameTextField.text.isEmpty { user.firstName = firstNameTextField.text }
        if !lastNameTextField.text.isEmpty { user.lastName = lastNameTextField.text }
        if !emailTextField.text.isEmpty { user.email = emailTextField.text }
        //if !dreamSchoolTextField.text.isEmpty { user.dreamSchool = dreamSchoolTextField.text }
        //if !locationTextField.text.isEmpty { user.location = locationTextField.text }
        //if !ageTextField.text.isEmpty { user.age = ageTextField.text.toInt()? }

        
        if refreshObjects() {
            parent.user = user
            navigationController?.popToViewController(parent, animated: true)
        } else {
            println("Error refreshing objects")
        }
        
    }
    
    
    func refreshObjects() -> Bool {
        let managedContext = user.managedObjectContext!
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
            return false
        }
        println("User Context Saved (or it should be?)")
        
        return true
    }
    
}