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
//BUGS: There is a removing favorite school bug, does not show correctly the removed school!

class MySchoolsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var user: User!
    var numSchools:Int!
    var schools: NSMutableArray!
    var currentSchool: School!
    
    
    @IBOutlet weak var mySchoolsLabel: UILabel!
    @IBOutlet weak var adjustRanksOutlet: UIButton!
    @IBOutlet weak var schoolTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Schools"
        mySchoolsLabel.text = "\(user.firstName)\'s Schools"
        
        schools = NSMutableArray(array: user.favoriteSchools.allObjects)
        
        schoolTableView?.rowHeight = 50
        //Gets rid of extra white space in top
        self.automaticallyAdjustsScrollViewInsets = false
        println("\(schoolTableView!.numberOfSections())")
        
        for school in schools {
            for rating in user.rating {
                if school.rating.member(rating) != nil {
                    //School and user rating has been matched
                    (school as School).temporaryRating = rating as Rating
                    break
                }
            }
            //Should always be found?
            println("\((school as School).schoolName)'s Total Score: \((school as School).temporaryRating.totalScore)")
        }
        
        
        var j = 1
        for school in schools {
            println("\(j): \(school.schoolName)")
            j++
        }
        
        //PDAlert: This is shitty implementation but is okay for now...
        var tempSchoolArray = NSMutableArray()
        let totalSchools = schools.count
        for var i = 0; i < totalSchools; i++ {
            var highestScore = Float(-1)
            var highestScoringSchool: School!
            for school in schools {
                if Float((school as School).temporaryRating.totalScore) > highestScore {
                    highestScore = Float((school as School).temporaryRating.totalScore)
                    highestScoringSchool = (school as School)
                }
            }
            println("Highest Score: \(highestScore)")
            println("Removed school = \(highestScoringSchool.schoolName)")
            tempSchoolArray.addObject(highestScoringSchool as School)
            schools.removeObject(highestScoringSchool as School)
        }
        schools.removeAllObjects()
        schools = tempSchoolArray
        
        
        
       
    }
    
    //PDAlert: There may be a bug that arises if a user unfavorites and then hits back!
    override func viewWillAppear(animated: Bool) {
        var tempSchoolArray = NSMutableArray()
        let totalSchools = schools.count
        for var i = 0; i < totalSchools; i++ {
            var highestScore = Float(-1)
            var highestScoringSchool: School!
            for school in schools {
                if Float((school as School).temporaryRating.totalScore) > highestScore {
                    highestScore = Float((school as School).temporaryRating.totalScore)
                    highestScoringSchool = (school as School)
                }
            }
            println("Highest Score: \(highestScore)")
            println("Removed school = \(highestScoringSchool.schoolName)")
            tempSchoolArray.addObject(highestScoringSchool as School)
            schools.removeObject(highestScoringSchool as School)
        }
        schools.removeAllObjects()
        schools = tempSchoolArray
        schoolTableView.reloadData()
    }
    
    func compareScores(schoolOne: School, schoolTwo: School) -> NSComparisonResult {
        return schoolOne.temporaryRating.totalScore.compare(schoolTwo.temporaryRating.totalScore)
    }
    
    //reload data function can be used
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = SchoolTableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
        //cell.school = schools[indexPath.row]
        cell.school = schools.objectAtIndex(indexPath.row) as School
        cell.rank = indexPath.row
        let bgcolor = UIColor(red: 5, green: 5, blue: 5, alpha: 1)
        cell.backgroundColor = self.view.backgroundColor
        
        //Currently organized by just total
        cell.textLabel?.text = "\(Float(cell.school.temporaryRating.totalScore) / 5.0)"
        cell.textLabel?.textColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1)
        cell.textLabel?.font = UIFont(name: "Avenir Heavy", size: 16.0)
        //cell.textLabel?.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        cell.detailTextLabel?.text = "\(cell.school.schoolName)" //Maybe display Rank
        cell.detailTextLabel?.font = UIFont(name: "Avenir Heavy", size: 16.0)
        return cell
    }
    //Making header title
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Schools by Rank"
        } else {
            return ""
        }
    }
    //Ranks will also need to be adjusted and saved for the user here so it can order it properly
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        //let thisSchool = schools[sourceIndexPath.row]
        let thisSchool = schools.objectAtIndex(sourceIndexPath.row) as School
        //schools.removeAtIndex(sourceIndexPath.row)
        schools.removeObjectAtIndex(sourceIndexPath.row)
        //schools.insert(thisSchool, atIndex: destinationIndexPath.row)
        schools.insertObject(thisSchool, atIndex: destinationIndexPath.row)
        println("Index path moved")
        
    }
    /*Header detail  ----- Implement later
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var myView = UIView()
        //myView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        //let myLabel = UILabel()
        //myLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        //myView.addSubview(myLabel)
        return myView
        
    }
    */
    
    //Stops the indent from happening
    func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    //Makes it so there is no delete button (viewed)
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.None
    }
    //Allows ALL cells to be moved
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    //Row selected - > go to school page, perhaps make dropdown, then select go
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //probably can just use tableView instead of schoolTableView
        let thisCell = schoolTableView.cellForRowAtIndexPath(indexPath) as SchoolTableViewCell
        let schoolViewController = storyboard?.instantiateViewControllerWithIdentifier("SchoolViewController") as SchoolViewController
        schoolViewController.user = user
        schoolViewController.school = thisCell.school
        navigationController?.pushViewController(schoolViewController, animated: true)
    }
    //Returns all schools favorited by user
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.favoriteSchools.count
    }
    
    @IBAction func adjustRanksTapped(sender: AnyObject) {
        if schoolTableView.editing { //Currently in edit mode
            schoolTableView.setEditing(false, animated: true)
            adjustRanksOutlet.setTitle("Adjust Ranks", forState: .Normal)
            
        } else { //Not editing
            schoolTableView.setEditing(true, animated: true)
            adjustRanksOutlet.setTitle("Save Ranks", forState: .Normal)
        }
       
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func closeSchool(segue: UIStoryboardSegue) {
        //
    }
}
