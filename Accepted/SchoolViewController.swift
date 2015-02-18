//
//  SchoolViewController.swift
//  Accepted
//
//  Created by Philip Deisinger on 2/1/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit

class SchoolViewController : UIViewController {
    
    var user: User!
    var school: School!
    
    @IBOutlet weak var schoolIconImageView: UIImageView!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var schoolLocationLabel: UILabel!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    ///****  ALL OF THIS WILL BE AUTOMATED FROM COREDATA ****///
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var textView = UITextView(frame: CGRectMake(20, 50, 330, 700))
        textView.text = "Test text"
        textView.scrollEnabled = true
        textView.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        textView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        textView.editable = false
        
        var textView2 = UITextView(frame: CGRectMake(20, 500, 330, 700))
        textView2.text = "Test text2"
        textView2.scrollEnabled = true
        textView2.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        textView2.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        textView2.editable = false
        
        //mainScrollView.addSubview(textView)
        //mainScrollView.addSubview(textView2)
        schoolIconImageView.image = UIImage(named: "\(school.schoolName)")
        schoolNameLabel.text = school.schoolName
        schoolLocationLabel.text = school.location
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidDisappear(animated: Bool) {
        schoolNameLabel.text = ""
        schoolLocationLabel.text = ""
        
    }
}
