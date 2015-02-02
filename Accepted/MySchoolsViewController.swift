//
//  MySchoolsViewController.swift
//  Accepted
//
//  Created by Philip Deisinger on 1/29/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit
import CoreData

//Need to add DataSource and Delegate of tableview as well, find the overridden methods
class MySchoolsViewController: UIViewController {
    
    var user: User!
    var numSchools:Int!
    
    @IBOutlet weak var numSchoolsLabel: UILabel!
    @IBOutlet weak var tempSchoolTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Schools"
        
        numSchoolsLabel.text = "Number of Schools: \(user.favoriteSchools.count)"
        if let madison = user.favoriteSchools.allObjects as? [School] {
            for school in madison {
                tempSchoolTextView.text =
                "School Name: \(school.schoolName)\nSchool Mascot: \(school.nickName)\n Favorited by \(school.favoritedByUsers.count) users"
            }
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
