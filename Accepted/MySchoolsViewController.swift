//
//  MySchoolsViewController.swift
//  Accepted
//
//  Created by Philip Deisinger on 1/29/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit
import CoreData

class MySchoolsViewController: UIViewController {
    
    var user:NSManagedObject!
    var numSchools:Int!
    
    @IBOutlet weak var numSchoolsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Schools"
        if (user!.valueForKey("age")? != nil) {
            numSchools = user!.valueForKey("age") as NSInteger
            numSchoolsLabel.text = "Number of Schools: \(numSchools)"
        } else {
            numSchoolsLabel.text = "Number of Schools: 0"
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func schoolButtonTapped(sender: AnyObject) {
        let schoolViewController = storyboard?.instantiateViewControllerWithIdentifier("SchoolViewController") as SchoolViewController
        schoolViewController.schoolName = "UW-Madison"
        schoolViewController.schoolLocation = "Madison, WI"
        presentViewController(schoolViewController, animated: true, completion: nil)
    }
    
    @IBAction func closeSchool(segue: UIStoryboardSegue) {
        //
    }
}
