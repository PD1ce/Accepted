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
    
    @IBOutlet weak var schoolIconImageView: UIImageView!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var schoolLocationLabel: UILabel!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var favButtonView: UIButton!
    ///****  ALL OF THIS WILL BE AUTOMATED FROM COREDATA ****///
    @IBOutlet weak var favoritedLabel: UILabel!
    
    var scrollImageView: UIImageView!
    
    
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
        
        let image = UIImage(named: "mountainTest")!
        scrollImageView = UIImageView(image: image)
        scrollImageView.frame = CGRect(origin: CGPointMake(0, 0), size: image.size)
        mainScrollView.addSubview(scrollImageView)
        mainScrollView.contentSize = image.size
        
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
}
