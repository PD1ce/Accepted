//
//  DevToolsViewController.swift
//  Accepted
//
//  Created by Philip Deisinger on 2/1/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//


import UIKit
import Foundation
import CoreData

class DevToolsViewController : UIViewController {
    
    var users = [NSManagedObject]()
    
    @IBOutlet weak var deleteUsersLabel: UILabel!
    @IBOutlet weak var deleteSchoolsLabel: UILabel!
    @IBOutlet weak var populateUsersLabel: UILabel!
    @IBOutlet weak var populateSchoolsLabel: UILabel!
    @IBOutlet weak var importSchoolsLabel: UILabel!
    
    var alertController: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func populateUsersTapped(sender: AnyObject) {
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        deleteUsersLabel.text = ""
        deleteSchoolsLabel.text = ""
        populateUsersLabel.text = ""
        populateSchoolsLabel.text = ""
    }
    
    
    /**
    *
    *  This should eventually take server/Wiki data
    *   Or perhaps an imported JSON docutment
    *   For now, all is hard coded because too bad
    */
    @IBAction func populateSchoolsTapped(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        /////
        let uwmadison = NSEntityDescription.insertNewObjectForEntityForName("School", inManagedObjectContext: managedContext) as School
        uwmadison.schoolName = "University of Wisconsin-Madison"
        uwmadison.location = "Madison, WI"
        uwmadison.nickName = "Badgers"
        uwmadison.latitude = 43.076592
        uwmadison.longitude = -89.412487
        /////
        let marquette = NSEntityDescription.insertNewObjectForEntityForName("School", inManagedObjectContext: managedContext) as School
        marquette.schoolName = "Marquette University"
        marquette.location = "Milwaukee, WI"
        marquette.nickName = "Golden Eagles"
        marquette.latitude = 43.038851
        marquette.longitude = -87.930424
        /////
        let uwlacrosse = NSEntityDescription.insertNewObjectForEntityForName("School", inManagedObjectContext: managedContext) as School
        uwlacrosse.schoolName = "University of Wisconsin-La Crosse"
        uwlacrosse.location = "La Crosse, WI"
        uwlacrosse.nickName = "Eagles"
        uwlacrosse.latitude = 43.815731
        uwlacrosse.longitude = -91.233002
        /////
        let uwoshkosh = NSEntityDescription.insertNewObjectForEntityForName("School", inManagedObjectContext: managedContext) as School
        uwoshkosh.schoolName = "University of Wisconsin-Oshkosh"
        uwoshkosh.location = "Oshkosh, WI"
        uwoshkosh.nickName = "Titans"
        uwoshkosh.latitude = 44.021364
        uwoshkosh.longitude = -88.550861
        /////
        let uwwhitewater = NSEntityDescription.insertNewObjectForEntityForName("School", inManagedObjectContext: managedContext) as School
        uwwhitewater.schoolName = "University of Wisconsin-Whitewater"
        uwwhitewater.location = "Whitewater, WI"
        uwwhitewater.nickName = "Warhawks"
        uwwhitewater.latitude = 42.838355
        uwwhitewater.longitude = -88.743224
        /////
        
        var error : NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
            populateSchoolsLabel.text = "Error Populating"
        } else {
            populateSchoolsLabel.text = "Schools Populated!"
        }
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
    
    @IBAction func importSchoolsTapped(sender: AnyObject) {
        makeWikiRequest()
    }
    
    func makeWikiRequest() {
        
        var url = "http://en.wikipedia.org/wiki/University_of_Wisconsin%E2%80%93Madison"
        var request = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: { (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            
            if (jsonResult != nil) {
            // process jsonResult
                println("\(jsonResult)")
            } else {
                println("error loading JSON")
            // couldn't load JSON, look at error
            }
            
            
            }
        )
    }
    
   
    @IBAction func regexSchoolTapped(sender: AnyObject) {
        let location = "/Users/Phil/Desktop/Swift/Accepted/Accepted/SchoolCurls.txt"
        var schoolString = NSString(contentsOfFile: location, encoding: NSUTF8StringEncoding, error: nil) as String
     
        
        let regex = NSRegularExpression(pattern: "infobox vcard(.*?)</table>", options: NSRegularExpressionOptions.DotMatchesLineSeparators, error: nil)
       
        
        let range = NSMakeRange(0, countElements(schoolString))
        let newString = regex?.stringByReplacingMatchesInString(schoolString, options: nil, range: range, withTemplate: "")
        println(newString)
    }


}