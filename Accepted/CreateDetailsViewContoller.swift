//
//  CreateDetailsViewContoller.swift
//  Accepted
//
//  Created by Philip Deisinger on 2/5/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CreateDetailsViewContoller : UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var ageNumberLabel: UILabel!
    @IBOutlet weak var gradeNumberLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var intendedMajorTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!

    @IBOutlet weak var ageSlider: UISlider!
    @IBOutlet weak var gradeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
