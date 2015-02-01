//
//  DevToolsViewController.swift
//  Accepted
//
//  Created by Philip Deisinger on 2/1/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//


import UIKit
import CoreData

class DevToolsViewController : UIViewController {
    
    var users = [NSManagedObject]()
    
    @IBOutlet weak var deleteUsersLabel: UILabel!
    @IBOutlet weak var deleteSchoolsLabel: UILabel!
    
    var alertController: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func deleteUsersTapped(sender: AnyObject) {
        alertController = UIAlertController(title: "Delete Users", message: "Are you sure you want to delete all users?", preferredStyle: UIAlertControllerStyle.Alert)
        let confirmAction = UIAlertAction(title: "Yes", style: .Default, handler: {
            action in
                if self.deleteUsers() {
                    self.deleteUsersLabel.text = "Users Deleted!"
                } else {
                    self.deleteUsersLabel.text = "Error deleting users."
                }
            }
        )
        let cancelAction = UIAlertAction(title: "No", style: .Default, handler: {
            action in
                self.deleteUsersLabel.text = "No users deleted."
            }
        )
            
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func deleteSchoolsTapped(sender: AnyObject) {
        
    }
    
    
    // Need to make sure this user object is being passed around appropriately!!//
    func deleteUsers() -> Bool {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        for user in users {
            managedContext.deleteObject(user)
        }

        var error : NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
            return false
        }
        return true
    }
    
    func deleteSchools() -> Bool {
        /* To be done when schools are instantiated
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        for user in users {
            managedContext.deleteObject(user)
        }
        
        var error : NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
            return false
        }
        return true
*/
        return false
    }

}