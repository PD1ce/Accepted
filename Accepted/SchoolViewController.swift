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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if user.favoriteSchools.containsObject(school) {
            isFavorite = true
            favButtonView.setImage(UIImage(named: "favSchoolYes"), forState: nil)
            println("Contains school!")
        } else {
            isFavorite = false
            favButtonView.setImage(UIImage(named: "favSchoolNo"), forState: nil)
            println("Does not contain school!")
        }
        
        scrollTextViews = [SchoolCardTextView]()
        
        let image = UIImage(named: "universityOfWisconsinMadisonLogo")!
        scrollImageView = UIImageView(image: image)
        scrollImageView.frame = CGRect(origin: CGPointMake(0, 0), size: image.size)
        //mainScrollView.addSubview(scrollImageView)
                //Data into scrollView
        
        let gestureRecTap = UITapGestureRecognizer(target: self, action: "textViewTapped")
        gestureRecTap.numberOfTapsRequired = 1
        gestureRecTap.numberOfTouchesRequired = 1
        
        
        for var i = 0; i < 5; i++ {
            var textView = SchoolCardTextView(frame: CGRect(x: (i * 50) + 5, y: 0, width: 300, height: 500))
            textView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
            textView.layer.cornerRadius = 10.0
            textView.position = i
            textView.open = false
            textView.text = "Stuff!"
            textView.layer.borderWidth = 5
            textView.editable = false
            textView.selectable = false
            textView.addGestureRecognizer(gestureRecTap)
            scrollTextViews.append(textView)
            mainScrollView.addSubview(textView)
        }
        mainScrollView.contentSize = CGSize(width: 375, height: 1000)
        
        //test
        testBool = false
        
        self.view.backgroundColor = UIColor(red: CGFloat(school.primaryRed), green: CGFloat(school.primaryGreen), blue: CGFloat(school.primaryBlue), alpha: 1)
        let textColor = UIColor(red: CGFloat(school.secondaryRed), green: CGFloat(school.secondaryGreen), blue: CGFloat(school.secondaryBlue), alpha: 1)
        
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
    
    func textViewTapped() {
        if !testBool {
            UIView.animateWithDuration(0.75, delay: 0.0, options: .CurveEaseInOut, animations: {
                self.scrollTextView2.center.x += 200
                self.scrollTextView3.center.x += 200
                self.scrollTextView4.center.x += 200
            
                }, completion: { finished in
                
                }
            )
            testBool = !testBool
        } else {
            UIView.animateWithDuration(0.75, delay: 0.0, options: .CurveEaseInOut, animations: {
                self.scrollTextView2.center.x -= 200
                self.scrollTextView3.center.x -= 200
                self.scrollTextView4.center.x -= 200
                
                }, completion: { finished in
                    
                }
            )
            testBool = !testBool
        }
    }
}
