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
    var selectedControl: SortingControl!
    
    var totalRatingView: SortingControl!
    var foodRatingView: SortingControl!
    var schoolSizeRatingView: SortingControl!
    var locationRatingView: SortingControl!
    var residenceHallsRatingView: SortingControl!
    var costRatingView: SortingControl!
    var academicFitRatingView: SortingControl!
    var athleticsRatingView: SortingControl!
    var environmentRatingView: SortingControl!
    var visitRatingView: SortingControl!
    
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
        
        
        
        
        //Total
        totalRatingView = SortingControl(frame: CGRect(x: 0, y: 200, width: 30, height: 30))
        totalRatingView.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        let trText = SortingTextView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        trText.text = "T"
        totalRatingView.addSubview(trText)
        selectedControl = totalRatingView // Initialize sorter
        //Food
        foodRatingView = SortingControl(frame: CGRect(x: 30, y: 200, width: 30, height: 30))
        let foodText = SortingTextView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        foodText.text = "F"
        foodRatingView.addSubview(foodText)
        //Class Size
        schoolSizeRatingView = SortingControl(frame: CGRect(x: 60, y: 200, width: 30, height: 30))
        let classSizeText = SortingTextView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        classSizeText.text = "S"
        schoolSizeRatingView.addSubview(classSizeText)
        //Location
        locationRatingView = SortingControl(frame: CGRect(x: 90, y: 200, width: 30, height: 30))
        let locationText = SortingTextView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        locationText.text = "L"
        locationRatingView.addSubview(locationText)
        //Residence Halls
        residenceHallsRatingView = SortingControl(frame: CGRect(x: 120, y: 200, width: 30, height: 30))
        let residenceHallsText = SortingTextView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        residenceHallsText.text = "R"
        residenceHallsRatingView.addSubview(residenceHallsText)
        //Cost
        costRatingView = SortingControl(frame: CGRect(x: 150, y: 200, width: 30, height: 30))
        let costText = SortingTextView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        costText.text = "C"
        costRatingView.addSubview(costText)
        //Academic Fit
        academicFitRatingView = SortingControl(frame: CGRect(x: 180, y: 200, width: 30, height: 30))
        let academicFitText = SortingTextView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        academicFitText.text = "F"
        academicFitRatingView.addSubview(academicFitText)
        //Athletics
        athleticsRatingView = SortingControl(frame: CGRect(x: 210, y: 200, width: 30, height: 30))
        let athleticsText = SortingTextView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        athleticsText.text = "A"
        athleticsRatingView.addSubview(athleticsText)
        //Environment
        environmentRatingView = SortingControl(frame: CGRect(x: 240, y: 200, width: 30, height: 30))
        let environmentText = SortingTextView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        environmentText.text = "E"
        environmentRatingView.addSubview(environmentText)
        //Visit
        visitRatingView = SortingControl(frame: CGRect(x: 270, y: 200, width: 30, height: 30))
        let visitText = SortingTextView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        visitText.text = "V"
        visitRatingView.addSubview(visitText)
        
        totalRatingView.addTarget(self, action: "totalRatingTapped", forControlEvents: .TouchUpInside)
        foodRatingView.addTarget(self, action: "foodRatingTapped", forControlEvents: .TouchUpInside)
        schoolSizeRatingView.addTarget(self, action: "schoolSizeRatingTapped", forControlEvents: .TouchUpInside)
        locationRatingView.addTarget(self, action: "locationRatingTapped", forControlEvents: .TouchUpInside)
        residenceHallsRatingView.addTarget(self, action: "residenceHallsRatingTapped", forControlEvents: .TouchUpInside)
        costRatingView.addTarget(self, action: "costRatingTapped", forControlEvents: .TouchUpInside)
        academicFitRatingView.addTarget(self, action: "academicFitRatingTapped", forControlEvents: .TouchUpInside)
        athleticsRatingView.addTarget(self, action: "athleticsRatingTapped", forControlEvents: .TouchUpInside)
        environmentRatingView.addTarget(self, action: "environmentRatingTapped", forControlEvents: .TouchUpInside)
        visitRatingView.addTarget(self, action: "visitRatingTapped", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(totalRatingView)
        self.view.addSubview(foodRatingView)
        self.view.addSubview(schoolSizeRatingView)
        self.view.addSubview(locationRatingView)
        self.view.addSubview(residenceHallsRatingView)
        self.view.addSubview(costRatingView)
        self.view.addSubview(academicFitRatingView)
        self.view.addSubview(athleticsRatingView)
        self.view.addSubview(environmentRatingView)
        self.view.addSubview(visitRatingView)
        
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
        selectedControl = totalRatingView
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
        //cell.backgroundColor = self.view.backgroundColor
        //Testing
        cell.backgroundColor = UIColor(red: CGFloat(cell.school.primaryRed), green: CGFloat(cell.school.primaryGreen), blue: CGFloat(cell.school.primaryBlue), alpha: 1.0)
        
        //Currently organized by just total
        /*
        if selectedControl == totalRatingView {
            cell.textLabel?.text = "\(Float(cell.school.temporaryRating.totalScore) / 5.0)"
        }
        */
        
        
        //PDAlert: When you sort by cost etc then click a school and return it is bugged
        // Might be fixes
        switch selectedControl {
            case totalRatingView:
                let tempString = NSString(format: "%.2f", (Float(cell.school.temporaryRating.totalScore) / 9.0))
                cell.textLabel?.text = "\(tempString)"
            case foodRatingView: cell.textLabel?.text = "\(Float(cell.school.temporaryRating.food))"
            case schoolSizeRatingView: cell.textLabel?.text = "\(Float(cell.school.temporaryRating.classSize))"
            case locationRatingView: cell.textLabel?.text = "\(Float(cell.school.temporaryRating.location))"
            case residenceHallsRatingView: cell.textLabel?.text = "\(Float(cell.school.temporaryRating.residenceHalls))"
            case costRatingView: cell.textLabel?.text = "\(Float(cell.school.temporaryRating.cost))"
            case academicFitRatingView: cell.textLabel?.text = "\(Float(cell.school.temporaryRating.academicFit))"
            case athleticsRatingView: cell.textLabel?.text = "\(Float(cell.school.temporaryRating.athletics))"
            case environmentRatingView: cell.textLabel?.text = "\(Float(cell.school.temporaryRating.environment))"
            case visitRatingView: cell.textLabel?.text = "\(Float(cell.school.temporaryRating.visit))"
            default: cell.textLabel?.text = "\(Float(cell.school.temporaryRating.totalScore) / 9.0)"
        }
        
        //cell.textLabel?.text = "\(Float(cell.school.temporaryRating.totalScore) / 5.0)"
        cell.textLabel?.textColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1)
        cell.textLabel?.font = UIFont(name: "Avenir Heavy", size: 16.0)
        cell.textLabel?.textColor = UIColor(red: CGFloat(cell.school.secondaryRed), green: CGFloat(cell.school.secondaryGreen), blue: CGFloat(cell.school.secondaryBlue), alpha: 1.0)
        //cell.textLabel?.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        cell.detailTextLabel?.text = "\(cell.school.schoolName)" //Maybe display Rank
        cell.detailTextLabel?.font = UIFont(name: "Avenir Heavy", size: 16.0)
        //Testing
        cell.detailTextLabel?.textColor = UIColor(red: CGFloat(cell.school.secondaryRed), green: CGFloat(cell.school.secondaryGreen), blue: CGFloat(cell.school.secondaryBlue), alpha: 1.0)
        return cell
    }
    //Making header title
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch selectedControl {
            case totalRatingView: return "Schools by Total Score"
            case foodRatingView: return "Schools by Food Score"
            case schoolSizeRatingView: return "Schools by Class Size Score"
            case locationRatingView: return "Schools by Location Score"
            case residenceHallsRatingView: return "Schools by Residence Halls Score"
            case costRatingView: return "Schools by Cost Score"
            case academicFitRatingView: return "Schools by Academic Fit Score"
            case athleticsRatingView: return "Schools by Athletics Score"
            case environmentRatingView: return "Schools by Environment Score"
            case visitRatingView: return "Schools by Visit Score"
            default: return "Schools by Total Score"
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
    
    func totalRatingTapped() {
        println("TotalTapped")
        selectedControl.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        selectedControl = totalRatingView
        selectedControl.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
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
    func foodRatingTapped() {
        println("FoodTapped")
        selectedControl.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        selectedControl = foodRatingView
        selectedControl.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        var tempSchoolArray = NSMutableArray()
        let totalSchools = schools.count
        for var i = 0; i < totalSchools; i++ {
            var highestScore = Float(-1)
            var highestScoringSchool: School!
            for school in schools {
                if Float((school as School).temporaryRating.food) > highestScore {
                    highestScore = Float((school as School).temporaryRating.food)
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
    func schoolSizeRatingTapped() {
        println("schoolsizeTapped")
        selectedControl.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        selectedControl = schoolSizeRatingView
        selectedControl.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        var tempSchoolArray = NSMutableArray()
        let totalSchools = schools.count
        for var i = 0; i < totalSchools; i++ {
            var highestScore = Float(-1)
            var highestScoringSchool: School!
            for school in schools {
                if Float((school as School).temporaryRating.classSize) > highestScore {
                    highestScore = Float((school as School).temporaryRating.classSize)
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
    func locationRatingTapped() {
        println("locationTapped")
        selectedControl.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        selectedControl = locationRatingView
        selectedControl.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        var tempSchoolArray = NSMutableArray()
        let totalSchools = schools.count
        for var i = 0; i < totalSchools; i++ {
            var highestScore = Float(-1)
            var highestScoringSchool: School!
            for school in schools {
                if Float((school as School).temporaryRating.location) > highestScore {
                    highestScore = Float((school as School).temporaryRating.location)
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
    func residenceHallsRatingTapped() {
        println("residenceHallsTapped")
        selectedControl.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        selectedControl = residenceHallsRatingView
        selectedControl.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        var tempSchoolArray = NSMutableArray()
        let totalSchools = schools.count
        for var i = 0; i < totalSchools; i++ {
            var highestScore = Float(-1)
            var highestScoringSchool: School!
            for school in schools {
                if Float((school as School).temporaryRating.residenceHalls) > highestScore {
                    highestScore = Float((school as School).temporaryRating.residenceHalls)
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
    func costRatingTapped() {
        println("costTapped")
        selectedControl.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        selectedControl = costRatingView
        selectedControl.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        var tempSchoolArray = NSMutableArray()
        let totalSchools = schools.count
        for var i = 0; i < totalSchools; i++ {
            var highestScore = Float(-1)
            var highestScoringSchool: School!
            for school in schools {
                if Float((school as School).temporaryRating.cost) > highestScore {
                    highestScore = Float((school as School).temporaryRating.cost)
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
    func academicFitRatingTapped() {
        println("academicFitTapped")
        selectedControl.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        selectedControl = academicFitRatingView
        selectedControl.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        var tempSchoolArray = NSMutableArray()
        let totalSchools = schools.count
        for var i = 0; i < totalSchools; i++ {
            var highestScore = Float(-1)
            var highestScoringSchool: School!
            for school in schools {
                if Float((school as School).temporaryRating.academicFit) > highestScore {
                    highestScore = Float((school as School).temporaryRating.academicFit)
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
    func athleticsRatingTapped() {
        println("athleticsTapped")
        selectedControl.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        selectedControl = athleticsRatingView
        selectedControl.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        var tempSchoolArray = NSMutableArray()
        let totalSchools = schools.count
        for var i = 0; i < totalSchools; i++ {
            var highestScore = Float(-1)
            var highestScoringSchool: School!
            for school in schools {
                if Float((school as School).temporaryRating.athletics) > highestScore {
                    highestScore = Float((school as School).temporaryRating.athletics)
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
    func environmentRatingTapped() {
        println("environmentTapped")
        selectedControl.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        selectedControl = environmentRatingView
        selectedControl.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        var tempSchoolArray = NSMutableArray()
        let totalSchools = schools.count
        for var i = 0; i < totalSchools; i++ {
            var highestScore = Float(-1)
            var highestScoringSchool: School!
            for school in schools {
                if Float((school as School).temporaryRating.environment) > highestScore {
                    highestScore = Float((school as School).temporaryRating.environment)
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
    func visitRatingTapped() {
        println("visitTapped")
        selectedControl.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        selectedControl = visitRatingView
        selectedControl.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        var tempSchoolArray = NSMutableArray()
        let totalSchools = schools.count
        for var i = 0; i < totalSchools; i++ {
            var highestScore = Float(-1)
            var highestScoringSchool: School!
            for school in schools {
                if Float((school as School).temporaryRating.visit) > highestScore {
                    highestScore = Float((school as School).temporaryRating.visit)
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
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func closeSchool(segue: UIStoryboardSegue) {
        //
    }
    
    //Used inside the UIControls for sorting
    class SortingTextView: UITextView {
        override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        override init(frame: CGRect, textContainer: NSTextContainer?) {
            super.init(frame: frame, textContainer: textContainer)
            editable = false
            selectable = false
            userInteractionEnabled = false
            font = UIFont(name: "Avenir Heavy", size: 16.0)
            self.textAlignment = NSTextAlignment(rawValue: 1)!
            self.contentOffset = CGPoint(x: 0.0, y: 8.0)
        }
        
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
    
    //UIControl in charge of sorting
    class SortingControl: UIControl {
        override init(frame: CGRect) {
            super.init(frame: frame)
            layer.borderWidth = 1
            layer.cornerRadius = 2
            backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }

        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
}
