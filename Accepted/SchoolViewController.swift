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
    var scrollTextView: UITextView!
    var scrollTextView2: UITextView!
    var scrollTextView3: UITextView!
    var scrollTextView4: UITextView!
    
    
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
        
        let image = UIImage(named: "universityOfWisconsinMadisonLogo")!
        scrollImageView = UIImageView(image: image)
        scrollImageView.frame = CGRect(origin: CGPointMake(0, 0), size: image.size)
        //mainScrollView.addSubview(scrollImageView)
                //Data into scrollView
        
        
        
        scrollTextView = UITextView(frame: CGRect(x: 5, y: 0, width: 200, height: 500))
        scrollTextView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        scrollTextView.layer.cornerRadius = 10.0
        scrollTextView.text = "ksjdfhaskldjhfaslkhjdg jkshdgkhjlasgjkhsaglkjsahdglkjhsadglkjhsadglkhas ghja sdklhg kalsjdhg kld g h jh klsadhjg lkadsgklhjasd ghjksad glkadslgkjahskljdghaskl dghalskdjhgjklasdhglkjahsghashjkgdsajkhgkljhads hjg kahjlsdg klhjasldg hjdas hj kljdhaskglhasdklhg lkasjdhg hepowughsudbgkjsad bkghljk adshglkj ahshg[weohgucjgadsjhgkjsdhgodvwqnuvnwdufghsalfhgsdjkabgawevaewhgajsdhgkljashfk baslkdbfnwbeufgbpwbgjklasbdgklbafeub weubfkbsd klfb askljdbfklwaefubwepufbasdbfabsd klbfkldhsabfjhab wfuaewfasdlkhfbbd"
        scrollTextView.layer.borderWidth = 5
        mainScrollView.addSubview(scrollTextView)
        mainScrollView.contentSize = CGSize(width: 375, height: 1000)
        
        
        scrollTextView2 = UITextView(frame: CGRect(x: 55, y: 0, width: 200, height: 500))
        scrollTextView2.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        scrollTextView2.layer.cornerRadius = 10.0
        scrollTextView2.text = "ksjdfhaskldjhfaslkhjdg jkshdgkhjlasgjkhsaglkjsahdglkjhsadglkjhsadglkhas ghja sdklhg kalsjdhg kld g h jh klsadhjg lkadsgklhjasd ghjksad glkadslgkjahskljdghaskl dghalskdjhgjklasdhglkjahsghashjkgdsajkhgkljhads hjg kahjlsdg klhjasldg hjdas hj kljdhaskglhasdklhg lkasjdhg hepowughsudbgkjsad bkghljk adshglkj ahshg[weohgucjgadsjhgkjsdhgodvwqnuvnwdufghsalfhgsdjkabgawevaewhgajsdhgkljashfk baslkdbfnwbeufgbpwbgjklasbdgklbafeub weubfkbsd klfb askljdbfklwaefubwepufbasdbfabsd klbfkldhsabfjhab wfuaewfasdlkhfbbd"
        scrollTextView2.layer.borderWidth = 5
        mainScrollView.addSubview(scrollTextView2)
        mainScrollView.contentSize = CGSize(width: 375, height: 1000)

        
        scrollTextView3 = UITextView(frame: CGRect(x: 105, y: 0, width: 200, height: 500))
        scrollTextView3.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        scrollTextView3.layer.cornerRadius = 10.0
        scrollTextView3.text = "ksjdfhaskldjhfaslkhjdg jkshdgkhjlasgjkhsaglkjsahdglkjhsadglkjhsadglkhas ghja sdklhg kalsjdhg kld g h jh klsadhjg lkadsgklhjasd ghjksad glkadslgkjahskljdghaskl dghalskdjhgjklasdhglkjahsghashjkgdsajkhgkljhads hjg kahjlsdg klhjasldg hjdas hj kljdhaskglhasdklhg lkasjdhg hepowughsudbgkjsad bkghljk adshglkj ahshg[weohgucjgadsjhgkjsdhgodvwqnuvnwdufghsalfhgsdjkabgawevaewhgajsdhgkljashfk baslkdbfnwbeufgbpwbgjklasbdgklbafeub weubfkbsd klfb askljdbfklwaefubwepufbasdbfabsd klbfkldhsabfjhab wfuaewfasdlkhfbbd"
        scrollTextView3.layer.borderWidth = 5
        mainScrollView.addSubview(scrollTextView3)
        mainScrollView.contentSize = CGSize(width: 375, height: 1000)

        
        scrollTextView4 = UITextView(frame: CGRect(x: 155, y: 0, width: 200, height: 500))
        scrollTextView4.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        scrollTextView4.layer.cornerRadius = 10.0
        scrollTextView4.text = "ksjdfhaskldjhfaslkhjdg jkshdgkhjlasgjkhsaglkjsahdglkjhsadglkjhsadglkhas ghja sdklhg kalsjdhg kld g h jh klsadhjg lkadsgklhjasd ghjksad glkadslgkjahskljdghaskl dghalskdjhgjklasdhglkjahsghashjkgdsajkhgkljhads hjg kahjlsdg klhjasldg hjdas hj kljdhaskglhasdklhg lkasjdhg hepowughsudbgkjsad bkghljk adshglkj ahshg[weohgucjgadsjhgkjsdhgodvwqnuvnwdufghsalfhgsdjkabgawevaewhgajsdhgkljashfk baslkdbfnwbeufgbpwbgjklasbdgklbafeub weubfkbsd klfb askljdbfklwaefubwepufbasdbfabsd klbfkldhsabfjhab wfuaewfasdlkhfbbd"
        scrollTextView4.layer.borderWidth = 5
        mainScrollView.addSubview(scrollTextView4)
        mainScrollView.contentSize = CGSize(width: 375, height: 1000)

        

        
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
        
        UIView.animateWithDuration(0.75, delay: 0.0, options: .CurveEaseOut, animations: {
            self.scrollTextView2.center.x += 100
            self.scrollTextView3.center.x += 100
            self.scrollTextView4.center.x += 100
            
            
            
            }, completion: { finished in
                
                
            })
        
    }
}
