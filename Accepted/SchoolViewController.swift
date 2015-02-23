//
//  SchoolViewController.swift
//  Accepted
//
//  Created by Philip Deisinger on 2/1/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit

class SchoolViewController : UIViewController, UIScrollViewDelegate {
    
    var user: User!
    var school: School!
    var isFavorite: Bool!
    
    var testBool: Bool!
    
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
    
    var scrollTextViews: [SchoolCardTextView]!
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
        
        let backgroundColor = UIColor(red: CGFloat(school.primaryRed), green: CGFloat(school.primaryGreen), blue: CGFloat(school.primaryBlue), alpha: 1)
        self.view.backgroundColor = backgroundColor
        let textColor = UIColor(red: CGFloat(school.secondaryRed), green: CGFloat(school.secondaryGreen), blue: CGFloat(school.secondaryBlue), alpha: 1)
        
        selectedColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        unselectedColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
        
        mainScrollView.bounces = false
        
        scrollTextViews = [SchoolCardTextView]()
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
        
        for var i = 0; i < 4; i++ {
            var textView = SchoolCardTextView(frame: CGRect(x: 0, y: 0, width: 375, height: 1000))
            textView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
            textView.layer.cornerRadius = 10.0
            textView.position = i
            textView.open = false
            textView.textAlignment = NSTextAlignment(rawValue: 1)!
            textView.font = UIFont(name: "Avenir Heavy", size: 20)
            textView.layer.borderWidth = 2
            textView.editable = false
            textView.selectable = false
            scrollTextViews.append(textView)
            mainScrollView.addSubview(textView)
            
            if i == 0 {
                generalView.associatedCard = textView
                textView.text = "General"
            } else if i == 1 {
                academicView.associatedCard = textView
                textView.text = "Academics"
            } else if i == 2 {
                athleticView.associatedCard = textView
                textView.text = "Athletics"
            } else if i == 3 {
                studentLifeView.associatedCard = textView
                textView.text = "Student Life"
            }
        }
        mainScrollView.contentSize = CGSize(width: 375, height: 1000)
        mainScrollView.bringSubviewToFront(scrollTextViews[0])
        
        //test
        testBool = false
        
        
        
        schoolNameLabel.textColor = textColor
        schoolLocationLabel.textColor = textColor
        favoritedLabel.textColor = textColor
        
        schoolIconImageView.image = UIImage(named: "\(school.schoolName)")
        schoolNameLabel.text = school.schoolName
        //schoolLocationLabel.text = school.location
    }
    
    override func viewDidDisappear(animated: Bool) {
        schoolNameLabel.text = ""
        schoolLocationLabel.text = ""
        favoritedLabel.text = ""
        
    }
    @IBAction func favSchoolTapped(sender: AnyObject) {
        if isFavorite! {
            favButtonView.setImage(UIImage(named: "favSchoolNo"), forState: nil)
            println("School unfavorited.")
            favoritedLabel.text = "School Unfavorited."
            isFavorite = !isFavorite
        } else {
            favButtonView.setImage(UIImage(named: "favSchoolYes"), forState: nil)
            println("School favorited!")
            favoritedLabel.text = "School Favorited!"
            isFavorite = !isFavorite
        }
    }
    
    // Gesture Actions
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
}
