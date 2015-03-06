//
//  SchoolViewController.swift
//  Accepted
//
//  Created by Philip Deisinger on 2/1/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit
import CoreData

class SchoolViewController : UIViewController, UIScrollViewDelegate {
    
    var user: User!
    var school: School!
    var rating: Rating!
    
    var isFavorite: Bool!
    
    var testBool: Bool!
    var textColor: UIColor!
    var backgroundColor: UIColor!
    
    @IBOutlet weak var schoolIconImageView: UIImageView!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var schoolLocationLabel: UILabel!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var favButtonView: UIButton!
    ///****  ALL OF THIS WILL BE AUTOMATED FROM COREDATA ****///
    @IBOutlet weak var favoritedLabel: UILabel!
    
    var scrollImageView: UIImageView!
    var scrollTextView:  UITextView!
    var scrollTextView2: UITextView!
    var scrollTextView3: UITextView!
    var scrollTextView4: UITextView!
    
    var infoViews: [UIView]!
    var headerViews: [SchoolCardHeaderView]!
    var selectedColor: UIColor!
    var unselectedColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if user.favoriteSchools.containsObject(school) {
            isFavorite = true
            favButtonView.setImage(UIImage(named: "favSchoolYes"), forState: nil)
        } else {
            isFavorite = false
            favButtonView.setImage(UIImage(named: "favSchoolNo"), forState: nil)
        }
        
        let myButton = UIControl(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        //myButton.addt
        
        
        /// PDAlert:
        // Ratings should be handled as follows
        // Each rating is assigned an id
        // this id is just a concatenation of the user id plus
        // the school id.  Will make finding ratings so much faster
        /*
        var fetchRequest = NSFetchRequest();
        fetchRequest.predicate = NSPredicate("school.name = %@ AND user.name = %@", "user1")
        user.managedObjectContext!.executeFetchRequest(fetchRequest)
        */
        
        let managedContext = user.managedObjectContext!
        var request = NSFetchRequest(entityName: "Rating")
        var error: NSError?
        let predicate = NSPredicate(format: "username = %@ AND schoolName = %@", user.username, school.schoolName)
        request.predicate = predicate
        let fetchedResults = managedContext.executeFetchRequest(request, error: &error) as [Rating]?
        
        //////////////////////////////////////////////////
        // PDAlert: Rating, User, and School need ids!!!!
        if !fetchedResults!.isEmpty {
            rating = fetchedResults![0]
        } else {
            let newRating = NSEntityDescription.insertNewObjectForEntityForName("Rating", inManagedObjectContext: user.managedObjectContext!) as Rating
            newRating.user = user
            newRating.school = school
            newRating.academicFit = 0
            newRating.academicFitMult = 1
            newRating.athletics = 0
            newRating.athleticsMult = 1
            newRating.classSize = 0
            newRating.classSizeMult = 1
            newRating.cost = 0
            newRating.costMult = 1
            newRating.environment = 0
            newRating.environmentMult = 1
            newRating.food = 0
            newRating.foodMult = 1
            newRating.location = 0
            newRating.locationMult = 1
            newRating.residenceHalls = 0
            newRating.residenceHallsMult = 1
            newRating.visit = 0
            newRating.visitMult = 1
            newRating.totalScore = 0
            newRating.schoolName = school.schoolName
            newRating.username = user.username
            
            let userRatings = user.rating.mutableCopy() as NSMutableSet
            userRatings.addObject(newRating)
            user.rating = userRatings
            let schoolRatings = school.rating.mutableCopy() as NSMutableSet
            schoolRatings.addObject(newRating)
            school.rating = schoolRatings
            
            self.rating = newRating
            
            if !saveObjects() {
                println("Error saving objects!")
            } else {
                
            }
            println("First Rating created!")
        }
        
        
        backgroundColor = UIColor(red: CGFloat(school.primaryRed), green: CGFloat(school.primaryGreen), blue: CGFloat(school.primaryBlue), alpha: 1)
        self.view.backgroundColor = backgroundColor
        textColor = UIColor(red: CGFloat(school.secondaryRed), green: CGFloat(school.secondaryGreen), blue: CGFloat(school.secondaryBlue), alpha: 1)
        
        selectedColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        unselectedColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
        
        mainScrollView.bounces = false
        mainScrollView.backgroundColor = backgroundColor
        
        infoViews = [UIView]()
        headerViews = [SchoolCardHeaderView]()
        
        let image = UIImage(named: "universityOfWisconsinMadisonLogo")!
        scrollImageView = UIImageView(image: image)
        scrollImageView.frame = CGRect(origin: CGPointMake(0, 0), size: image.size)
        //mainScrollView.addSubview(scrollImageView)
                //Data into scrollView


        //Instantiating GRs
        let generalViewTap = UITapGestureRecognizer(target: self, action: "generalViewTapped:")
        generalViewTap.numberOfTapsRequired = 1
        generalViewTap.numberOfTouchesRequired = 1
        let academicViewTap = UITapGestureRecognizer(target: self, action: "academicViewTapped:")
        academicViewTap.numberOfTapsRequired = 1
        academicViewTap.numberOfTouchesRequired = 1
        let athleticViewTap = UITapGestureRecognizer(target: self, action: "athleticViewTapped:")
        athleticViewTap.numberOfTapsRequired = 1
        athleticViewTap.numberOfTouchesRequired = 1
        let studentLifeViewTap = UITapGestureRecognizer(target: self, action: "studentLifeViewTapped:")
        studentLifeViewTap.numberOfTapsRequired = 1
        studentLifeViewTap.numberOfTouchesRequired = 1
        let ratingViewTap = UITapGestureRecognizer(target: self, action: "ratingViewTapped:")
        ratingViewTap.numberOfTapsRequired = 1
        ratingViewTap.numberOfTouchesRequired = 1
        
        
        //General Subview
        let generalView = SchoolCardHeaderView(frame: CGRect(x: 0, y: 227, width: 75, height: 30))
        generalView.text = "General"
        generalView.editable = false
        generalView.selectable = false
        generalView.backgroundColor = selectedColor
        generalView.textAlignment = NSTextAlignment(rawValue: 1)!
        generalView.font = UIFont(name: "Avenir Heavy", size: 14.0)
        generalView.textColor = textColor
        generalView.layer.cornerRadius = 10.0
        generalView.layer.zPosition = -1
        generalView.layer.borderWidth = 2
        generalView.layer.borderColor = textColor.CGColor
        generalView.addGestureRecognizer(generalViewTap)
        self.view.addSubview(generalView)
        headerViews.append(generalView)
        //Academic Subview
        let academicView = SchoolCardHeaderView(frame: CGRect(x: 75, y: 227, width: 75, height: 30))
        academicView.text = "Academics"
        academicView.editable = false
        academicView.selectable = false
        academicView.backgroundColor = unselectedColor
        academicView.textAlignment = NSTextAlignment(rawValue: 1)!
        academicView.font = UIFont(name: "Avenir Heavy", size: 14.0)
        academicView.textColor = textColor
        academicView.layer.cornerRadius = 10.0
        academicView.layer.zPosition = -1
        academicView.layer.borderWidth = 2
        academicView.layer.borderColor = textColor.CGColor
        academicView.addGestureRecognizer(academicViewTap)
        self.view.addSubview(academicView)
        headerViews.append(academicView)
        //Academic Subview
        let athleticView = SchoolCardHeaderView(frame: CGRect(x: 150, y: 227, width: 75, height: 30))
        athleticView.text = "Athletics"
        athleticView.editable = false
        athleticView.selectable = false
        athleticView.backgroundColor = unselectedColor
        athleticView.textAlignment = NSTextAlignment(rawValue: 1)!
        athleticView.font = UIFont(name: "Avenir Heavy", size: 14.0)
        athleticView.textColor = textColor
        athleticView.layer.cornerRadius = 10.0
        athleticView.layer.zPosition = -1
        athleticView.layer.borderWidth = 2
        athleticView.layer.borderColor = textColor.CGColor
        athleticView.addGestureRecognizer(athleticViewTap)
        self.view.addSubview(athleticView)
        headerViews.append(athleticView)
        //StudentLife Subview
        let studentLifeView = SchoolCardHeaderView(frame: CGRect(x: 225, y: 227, width: 100, height: 30))
        studentLifeView.text = "Student Life"
        studentLifeView.editable = false
        studentLifeView.selectable = false
        studentLifeView.backgroundColor = unselectedColor
        studentLifeView.textAlignment = NSTextAlignment(rawValue: 1)!
        studentLifeView.font = UIFont(name: "Avenir Heavy", size: 14.0)
        studentLifeView.textColor = textColor
        studentLifeView.layer.cornerRadius = 10.0
        studentLifeView.layer.zPosition = -1
        studentLifeView.layer.borderWidth = 2
        studentLifeView.layer.borderColor = textColor.CGColor
        studentLifeView.addGestureRecognizer(studentLifeViewTap)
        self.view.addSubview(studentLifeView)
        headerViews.append(studentLifeView)
        //Rating
        let ratingView = SchoolCardHeaderView(frame: CGRect(x: 325, y: 227, width: 50, height: 30))
        ratingView.text = "Rate"
        ratingView.editable = false
        ratingView.selectable = false
        ratingView.backgroundColor = unselectedColor
        ratingView.textAlignment = NSTextAlignment(rawValue: 1)!
        ratingView.font = UIFont(name: "Avenir Heavy", size: 14.0)
        ratingView.textColor = textColor
        
        /*
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: ratingView.bounds, byRoundingCorners: .TopLeft | .TopRight, cornerRadii: CGSize(width: CGFloat(10.0), height: CGFloat(10.0)))
        */
        
        ratingView.layer.cornerRadius = 10.0
        ratingView.layer.zPosition = -1
        ratingView.layer.borderWidth = 2
        ratingView.layer.borderColor = textColor.CGColor
        ratingView.addGestureRecognizer(ratingViewTap)
        self.view.addSubview(ratingView)
        headerViews.append(ratingView)
        
        //School cards under the headers
        for var i = 0; i < 5; i++ {
            var infoCardView = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 1000))
            
            if i == 0 { // General
                var textView = SchoolCardTextView(frame: CGRect(x: 5, y: 5, width: 365, height: 500))
                
                //View Properties!
                infoCardView.layer.borderColor = textColor.CGColor
                infoCardView.layer.borderWidth = 2
                infoCardView.layer.cornerRadius = 10.0
                
                //Textview Properties!
                textView.backgroundColor = backgroundColor
                textView.textColor = textColor
                textView.layer.cornerRadius = 10.0
                textView.position = i
                textView.open = false
                textView.textAlignment = NSTextAlignment(rawValue: 1)!
                textView.font = UIFont(name: "Avenir Heavy", size: 20)
                textView.layer.borderWidth = 2
                textView.layer.borderColor = textColor.CGColor
                textView.editable = false
                textView.selectable = false
                infoViews.append(infoCardView)
                mainScrollView.addSubview(infoCardView)

                generalView.associatedCard = infoCardView
                textView.text = "General"
                infoCardView.addSubview(textView)
            } else if i == 1 { // Academics
                var textView = SchoolCardTextView(frame: CGRect(x: 5, y: 5, width: 365, height: 500))
                
                //View Properties!
                infoCardView.layer.borderColor = textColor.CGColor
                infoCardView.layer.borderWidth = 2
                infoCardView.layer.cornerRadius = 10.0
                
                //Textview Properties!
                textView.backgroundColor = backgroundColor
                textView.textColor = textColor
                textView.layer.cornerRadius = 10.0
                textView.position = i
                textView.open = false
                textView.textAlignment = NSTextAlignment(rawValue: 1)!
                textView.font = UIFont(name: "Avenir Heavy", size: 20)
                textView.layer.borderWidth = 2
                textView.layer.borderColor = textColor.CGColor
                textView.editable = false
                textView.selectable = false
                infoViews.append(infoCardView)
                mainScrollView.addSubview(infoCardView)

                academicView.associatedCard = infoCardView
                textView.text = "Academics"
                infoCardView.addSubview(textView)
            } else if i == 2 { // Athletics
                var textView = SchoolCardTextView(frame: CGRect(x: 5, y: 5, width: 365, height: 500))
                
                //View Properties!
                infoCardView.layer.borderColor = textColor.CGColor
                infoCardView.layer.borderWidth = 2
                infoCardView.layer.cornerRadius = 10.0
                
                //Textview Properties!
                textView.backgroundColor = backgroundColor
                textView.textColor = textColor
                textView.layer.cornerRadius = 10.0
                textView.position = i
                textView.open = false
                textView.textAlignment = NSTextAlignment(rawValue: 1)!
                textView.font = UIFont(name: "Avenir Heavy", size: 20)
                textView.layer.borderWidth = 2
                textView.layer.borderColor = textColor.CGColor
                textView.editable = false
                textView.selectable = false
                infoViews.append(infoCardView)
                mainScrollView.addSubview(infoCardView)

                athleticView.associatedCard = infoCardView
                textView.text = "Athletics"
                infoCardView.addSubview(textView)
            } else if i == 3 { //Student Life
                var textView = SchoolCardTextView(frame: CGRect(x: 5, y: 5, width: 365, height: 500))
                
                //View Properties!
                infoCardView.layer.borderColor = textColor.CGColor
                infoCardView.layer.borderWidth = 2
                infoCardView.layer.cornerRadius = 10.0
                
                //Textview Properties!
                textView.backgroundColor = backgroundColor
                textView.textColor = textColor
                textView.layer.cornerRadius = 10.0
                textView.position = i
                textView.open = false
                textView.textAlignment = NSTextAlignment(rawValue: 1)!
                textView.font = UIFont(name: "Avenir Heavy", size: 20)
                textView.layer.borderWidth = 2
                textView.layer.borderColor = textColor.CGColor
                textView.editable = false
                textView.selectable = false
                infoViews.append(infoCardView)
                mainScrollView.addSubview(infoCardView)

                studentLifeView.associatedCard = infoCardView
                textView.text = "Student Life"
                infoCardView.addSubview(textView)
            } else if i == 4 { // Ratings
                infoCardView.backgroundColor = backgroundColor
                let titleLabel = UILabel(frame: CGRect(x: 5, y: 5, width: 365, height: 30))
                titleLabel.text = "Ratings"
                titleLabel.font = UIFont(name: "Avenir Heavy", size: 20)
                titleLabel.textColor = textColor
                titleLabel.textAlignment = NSTextAlignment(rawValue: 1)!
                infoCardView.addSubview(titleLabel)
                
                ///// Food Rating /////
                let foodRatingLabel = RatingLabel(frame: CGRect(x: 10, y: 60, width: 160, height: 20))
                foodRatingLabel.textColor = textColor
                foodRatingLabel.text = "Food"
                infoCardView.addSubview(foodRatingLabel)
                //Stars!
                let foodStarRating = StarRating(frame: CGRect(x: 200, y: 50, width: 160, height: 40), name: "food")
                foodStarRating.initialRatingUpdate(rating.food as Float)
                infoCardView.addSubview(foodStarRating)
                let foodGestureRec = UILongPressGestureRecognizer(target: self, action: "starRatingPressed:")
                foodGestureRec.numberOfTouchesRequired = 1
                foodGestureRec.minimumPressDuration = 0.01
                foodStarRating.addGestureRecognizer(foodGestureRec)
                
                ///// School Size Rating /////
                let schoolSizeRatingLabel = RatingLabel(frame: CGRect(x: 10, y: 120, width: 160, height: 20))
                schoolSizeRatingLabel.textColor = textColor
                schoolSizeRatingLabel.text = "Class Size"
                infoCardView.addSubview(schoolSizeRatingLabel)
                //Stars!
                let schoolSizeStarRating = StarRating(frame: CGRect(x: 200, y: 110, width: 160, height: 40), name: "classSize")
                schoolSizeStarRating.initialRatingUpdate(rating.classSize as Float)
                infoCardView.addSubview(schoolSizeStarRating)
                let schoolSizeGestureRec = UILongPressGestureRecognizer(target: self, action: "starRatingPressed:")
                schoolSizeGestureRec.numberOfTouchesRequired = 1
                schoolSizeGestureRec.minimumPressDuration = 0.01
                schoolSizeStarRating.addGestureRecognizer(schoolSizeGestureRec)
                
                ///// Location Rating /////
                let locationRatingLabel = RatingLabel(frame: CGRect(x: 10, y: 180, width: 160, height: 20))
                locationRatingLabel.textColor = textColor
                locationRatingLabel.text = "Location"
                infoCardView.addSubview(locationRatingLabel)
                //Stars!
                let locationStarRating = StarRating(frame: CGRect(x: 200, y: 170, width: 160, height: 40), name: "location")
                locationStarRating.initialRatingUpdate(rating.location as Float)
                infoCardView.addSubview(locationStarRating)
                let locationGestureRec = UILongPressGestureRecognizer(target: self, action: "starRatingPressed:")
                locationGestureRec.numberOfTouchesRequired = 1
                locationGestureRec.minimumPressDuration = 0.01
                locationStarRating.addGestureRecognizer(locationGestureRec)
                
                ///// Residence Halls Rating /////
                let residenceHallsRatingLabel = RatingLabel(frame: CGRect(x: 10, y: 240, width: 160, height: 20))
                residenceHallsRatingLabel.textColor = textColor
                residenceHallsRatingLabel.text = "Residence Halls"
                infoCardView.addSubview(residenceHallsRatingLabel)
                //Stars!
                let residenceHallsStarRating = StarRating(frame: CGRect(x: 200, y: 230, width: 160, height: 40), name: "residenceHalls")
                residenceHallsStarRating.initialRatingUpdate(rating.residenceHalls as Float)
                infoCardView.addSubview(residenceHallsStarRating)
                let residenceHallsGestureRec = UILongPressGestureRecognizer(target: self, action: "starRatingPressed:")
                residenceHallsGestureRec.numberOfTouchesRequired = 1
                residenceHallsGestureRec.minimumPressDuration = 0.01
                residenceHallsStarRating.addGestureRecognizer(residenceHallsGestureRec)
                
                ///// School Cost Rating /////
                let schoolCostRatingLabel = RatingLabel(frame: CGRect(x: 10, y: 300, width: 160, height: 20))
                schoolCostRatingLabel.textColor = textColor
                schoolCostRatingLabel.text = "Cost"
                infoCardView.addSubview(schoolCostRatingLabel)
                //Stars!
                let schoolCostStarRating = StarRating(frame: CGRect(x: 200, y: 290, width: 160, height: 40), name: "cost")
                schoolCostStarRating.initialRatingUpdate(rating.cost as Float)
                infoCardView.addSubview(schoolCostStarRating)
                let costGestureRec = UILongPressGestureRecognizer(target: self, action: "starRatingPressed:")
                costGestureRec.numberOfTouchesRequired = 1
                costGestureRec.minimumPressDuration = 0.01
                schoolCostStarRating.addGestureRecognizer(costGestureRec)

                //View Properties!
                infoCardView.layer.borderColor = textColor.CGColor
                infoCardView.layer.borderWidth = 2
                infoCardView.layer.cornerRadius = 10.0
                
                infoViews.append(infoCardView)
                mainScrollView.addSubview(infoCardView)

                ratingView.associatedCard = infoCardView
                
            }
            
        }
        mainScrollView.contentSize = CGSize(width: 375, height: 1000)
        mainScrollView.bringSubviewToFront(infoViews[0])
        
        //test
        testBool = false

        schoolNameLabel.textColor = textColor
        schoolLocationLabel.textColor = textColor
        favoritedLabel.textColor = textColor
        
        schoolIconImageView.image = UIImage(named: "\(school.schoolName)")
        schoolNameLabel.text = school.schoolName
        schoolLocationLabel.text = "\(school.city), \(school.state)"
    }
    
    override func viewDidDisappear(animated: Bool) {
        schoolNameLabel.text = ""
        schoolLocationLabel.text = ""
        favoritedLabel.text = ""
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        //Save ratings!!
        rating.updateTotal()
        if !saveObjects() {
            println("Error saving objects!")
        } else {
            
        }

    }
    
    @IBAction func favSchoolTapped(sender: AnyObject) {
        if isFavorite! {
            favButtonView.setImage(UIImage(named: "favSchoolNo"), forState: nil)
            println("School unfavorited.")
            favoritedLabel.text = "School Unfavorited."
            isFavorite = !isFavorite
            
            let utwo = user.favoriteSchools.mutableCopy() as NSMutableSet
            utwo.removeObject(school)
            user.favoriteSchools = utwo
            let stwo = school.favoritedByUsers.mutableCopy() as NSMutableSet
            stwo.removeObject(user)
            school.favoritedByUsers = stwo
            
            if !saveObjects() {
                println("Error saving objects!")
            } else {
        
            }

            
        } else {
            favButtonView.setImage(UIImage(named: "favSchoolYes"), forState: nil)
            println("School favorited!")
            favoritedLabel.text = "School Favorited!"
            isFavorite = !isFavorite
            
            let utwo = user.favoriteSchools.mutableCopy() as NSMutableSet
            utwo.addObject(school)
            user.favoriteSchools = utwo
            let stwo = school.favoritedByUsers.mutableCopy() as NSMutableSet
            stwo.addObject(user)
            school.favoritedByUsers = stwo
            
            if !saveObjects() {
                println("Error saving objects!")
            } else {
                
            }
            
        }
    }
    
    // Gesture Actions - Consolidate to just one!!
    // PDAlert: These can all be repurposed to UIControl !!
    func generalViewTapped(gr: UITapGestureRecognizer) {
        println("tappedG!")
        for header in headerViews {
            if header != gr.view {
                header.backgroundColor = unselectedColor
            } else {
                header.backgroundColor = selectedColor
            }
        }
        mainScrollView.bringSubviewToFront((gr.view as SchoolCardHeaderView).associatedCard)
    }
    func academicViewTapped(gr: UITapGestureRecognizer) {
        println("tappedAc!")
        for header in headerViews {
            if header != gr.view {
                header.backgroundColor = unselectedColor
            } else {
                header.backgroundColor = selectedColor
            }
        }
        mainScrollView.bringSubviewToFront((gr.view as SchoolCardHeaderView).associatedCard)
    }
    func athleticViewTapped(gr: UITapGestureRecognizer) {
        println("tappedAth!")
        for header in headerViews {
            if header != gr.view {
                header.backgroundColor = unselectedColor
            } else {
                header.backgroundColor = selectedColor
            }
        }
        mainScrollView.bringSubviewToFront((gr.view as SchoolCardHeaderView).associatedCard)
    }
    func studentLifeViewTapped(gr: UITapGestureRecognizer) {
        println("tappedSL!")
        for header in headerViews {
            if header != gr.view {
                header.backgroundColor = unselectedColor
            } else {
                header.backgroundColor = selectedColor
            }
        }
        mainScrollView.bringSubviewToFront((gr.view as SchoolCardHeaderView).associatedCard)
    }
    func ratingViewTapped(gr: UITapGestureRecognizer) {
        println("tappedRV!")
        for header in headerViews {
            if header != gr.view {
                header.backgroundColor = unselectedColor
            } else {
                header.backgroundColor = selectedColor
            }
        }
        mainScrollView.bringSubviewToFront((gr.view as SchoolCardHeaderView).associatedCard)
    }
    
    func saveObjects() -> Bool {
        let managedContext = user.managedObjectContext!
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
            return false
        }
        println("User Context Saved (or it should be?)")
        
        return true
    }
    
    func starRatingPressed(gr: UILongPressGestureRecognizer) {
        let thisRating = gr.view as StarRating
        thisRating.updateRating(gr.locationInView(gr.view).x)
        switch thisRating.name {
            case "food":
                rating.food = thisRating.rating
            case "classSize":
                rating.classSize = thisRating.rating
            case "location":
                rating.location = thisRating.rating
            case "residenceHalls":
                rating.residenceHalls = thisRating.rating
            case "cost":
                rating.cost = thisRating.rating
            default:
                println("error in name")
        }
    }
    
    class RatingLabel: UILabel {
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.font = UIFont(name: "Avenir Heavy", size: 18)
        }
        
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
}
