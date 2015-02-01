//
//  SchoolViewController.swift
//  Accepted
//
//  Created by Philip Deisinger on 2/1/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit

class SchoolViewController : UIViewController {
    
    var schoolName: String!
    var schoolLocation: String!
    
    @IBOutlet weak var schoolIconImageView: UIImageView!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var schoolLocationLabel: UILabel!
    
    
    ///****  ALL OF THIS WILL BE AUTOMATED FROM COREDATA ****///
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        schoolIconImageView.image = UIImage(named: "bucky-icon")
        schoolNameLabel.text = schoolName
        schoolLocationLabel.text = schoolLocation
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
