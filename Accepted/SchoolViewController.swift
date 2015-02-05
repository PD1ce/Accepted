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
    @IBOutlet weak var schoolDescTextView: UITextView!
    
    ///****  ALL OF THIS WILL BE AUTOMATED FROM COREDATA ****///
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        schoolIconImageView.image = UIImage(named: "\(school.schoolName)")
        schoolNameLabel.text = school.schoolName
        schoolLocationLabel.text = school.location
        schoolDescTextView.text = "School Team: \(school.nickName)\n\(school.favoritedByUsers.count) users have favorited this school"
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
