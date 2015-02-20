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
        
        let data = NSData(contentsOfFile: "/Users/Phil/Desktop/Swift/Accepted/Accepted/Schools.json")
        let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments,error: nil)
        let schoolArray = parsedObject as NSArray
        for school in schoolArray {
            
            let newSchool = NSEntityDescription.insertNewObjectForEntityForName("School", inManagedObjectContext: managedContext) as School
            newSchool.schoolName = school.valueForKey("schoolName") as String
            
            newSchool.latitude = school.valueForKey("latitude") as Float
            newSchool.longitude = school.valueForKey("longitude") as Float
            
            //newSchool.establishedDate = school.valueForKey("founded") as NSNumber
            newSchool.athleticConference = school.valueForKey("athleticConference") as String
            /*
            newSchool.city = school.valueForKey("city") as String
            newSchool.state = school.valueForKey("state") as String
            newSchool.publicPrivate = school.valueForKey("publicprivate") as String
            newSchool.inStateTuition = school.valueForKey("inStateTuition") as NSNumber
            newSchool.outOfStateTuition = school.valueForKey("outOfStateTuition") as NSNumber
            newSchool.studentsTotal = school.valueForKey("studentPopulation") as NSNumber
            //newSchool.endowment = school.valueForKey("endowment") as String // Number!!
            newSchool.acceptanceRate = school.valueForKey("acceptanceRate") as Float
            */
            
            //Parsing school colors - Test
            /**********************************/
            let primaryColorString = school.valueForKey("primaryColor") as NSString
            let secondaryColorString = school.valueForKey("secondaryColor") as NSString
            var primaryRed: String; var primaryGreen: String; var primaryBlue: String; var secRed: String; var secGreen: String; var secBlue: String;
            primaryRed = primaryColorString.substringWithRange(NSRange(location: 0, length: 2))
            primaryGreen = primaryColorString.substringWithRange(NSRange(location: 2, length: 2))
            primaryBlue = primaryColorString.substringWithRange(NSRange(location: 4, length: 2))
            secRed = secondaryColorString.substringWithRange(NSRange(location: 0, length: 2))
            secGreen = secondaryColorString.substringWithRange(NSRange(location: 2, length: 2))
            secBlue = secondaryColorString.substringWithRange(NSRange(location: 4, length: 2))
            
            let red1     = hexToDec(primaryRed)
            let green1   = hexToDec(primaryGreen)
            let blue1    = hexToDec(primaryBlue)
            let red2     = hexToDec(secRed)
            let green2   = hexToDec(secGreen)
            let blue2    = hexToDec(secBlue)
            
            newSchool.primaryRed = red1
            newSchool.primaryGreen = green1
            newSchool.primaryBlue = blue1
            newSchool.secondaryRed = red2
            newSchool.secondaryGreen = green2
            newSchool.secondaryBlue = blue2
            /***********************************/
            
            
            
        }
        
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
    
    func hexToDec(hex: NSString) -> Float {
        var firstDigit: Int
        var secondDigit: Int
        let firstHex = hex.substringWithRange(NSRange(location: 0, length: 1))
        let secondHex = hex.substringWithRange(NSRange(location: 1, length: 1))
        switch firstHex {
            case "0": firstDigit = 0
            case "1": firstDigit = 1
            case "2": firstDigit = 2
            case "3": firstDigit = 3
            case "4": firstDigit = 4
            case "5": firstDigit = 5
            case "6": firstDigit = 6
            case "7": firstDigit = 7
            case "8": firstDigit = 8
            case "9": firstDigit = 9
            case "a": firstDigit = 10
            case "b": firstDigit = 11
            case "c": firstDigit = 12
            case "d": firstDigit = 13
            case "e": firstDigit = 14
            case "f": firstDigit = 15
        	default : firstDigit = firstHex.toInt()!
        }
        switch secondHex {
            case "0": secondDigit = 0
            case "1": secondDigit = 1
            case "2": secondDigit = 2
            case "3": secondDigit = 3
            case "4": secondDigit = 4
            case "5": secondDigit = 5
            case "6": secondDigit = 6
            case "7": secondDigit = 7
            case "8": secondDigit = 8
        	case "9": secondDigit = 9
        	case "a": secondDigit = 10
            case "b": secondDigit = 11
            case "c": secondDigit = 12
            case "d": secondDigit = 13
        	case "e": secondDigit = 14
            case "f": secondDigit = 15
            default : secondDigit = firstHex.toInt()!
        }
        
        
        return Float(firstDigit * 16 + secondDigit) / 256
    }


}