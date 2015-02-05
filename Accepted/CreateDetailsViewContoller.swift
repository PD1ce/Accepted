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

class CreateDetailsViewContoller : UIViewController, UITextFieldDelegate {
    
    var user: User!
    var progress: Float!
    //var progress: UIProgressView!
    var parentVC: CreateAccountViewController!
    var ageSliderProgress = false
    var gradeSliderProgress = false
    var firstNameProgress = false
    var lastNameProgress = false
    var emailProgress = false
    var intendedMajorProgress = false
    var addressProgress = false
    var cityProgress = false
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var ageNumberLabel: UILabel!
    @IBOutlet weak var gradeNumberLabel: UILabel!
    @IBOutlet weak var saveDetailsLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var intendedMajorTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!

    @IBOutlet weak var ageSlider: UISlider!
    @IBOutlet weak var gradeSlider: UISlider!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = "\(user.username)"
        //progress = progressView
        ageNumberLabel.text = "?"
        gradeNumberLabel.text = "?"
        progressView.progress = 0
        progress = 0.0
    }
    
    @IBAction func ageSliderChanged(sender: AnyObject) {
        ageNumberLabel.text = "\(Int(ageSlider.value))"
        if !ageSliderProgress {
            ageSliderProgress = true
            progress = progress + 0.125
            progressView.setProgress(progress, animated: true)
        }
        
    }
    @IBAction func gradeSliderChanged(sender: AnyObject) {
        gradeNumberLabel.text = "\(Int(gradeSlider.value))"
        if !gradeSliderProgress {
            gradeSliderProgress = true
            progress = progress + 0.125
            progressView.setProgress(progress, animated: true)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == firstNameTextField && textField.text != "" {
            if !firstNameProgress {
                firstNameProgress = true
                progress = progress + 0.125
                progressView.setProgress(progress, animated: true)
            }
        } else if textField == lastNameTextField && textField.text != "" {
            if !lastNameProgress {
                lastNameProgress = true
                progress = progress + 0.125
                progressView.setProgress(progress, animated: true)
            }
        } else if textField == emailTextField && textField.text != "" {
            if !emailProgress {
                emailProgress = true
                progress = progress + 0.125
                progressView.setProgress(progress, animated: true)
            }
        } else if textField == intendedMajorTextField && textField.text != "" {
            if !intendedMajorProgress {
                intendedMajorProgress = true
                progress = progress + 0.125
                progressView.setProgress(progress, animated: true)
            }
        } else if textField == addressTextField && textField.text != "" {
            if !addressProgress {
                addressProgress = true
                progress = progress + 0.125
                progressView.setProgress(progress, animated: true)
            }
        } else if textField == cityTextField && textField.text != "" {
            if !cityProgress {
                cityProgress = true
                progress = progress + 0.125
                progressView.setProgress(progress, animated: true)
            }
        }
    }
    
    @IBAction func saveDetailsTapped(sender: AnyObject) {
        var allFieldsFilled = false
        if progressView.progress == 1.0 {
            allFieldsFilled = true
            user.age = Int(ageSlider.value)
            user.grade = Int(gradeSlider.value)
            user.firstName = firstNameTextField.text
            user.lastName = lastNameTextField.text
            user.email = emailTextField.text
            user.intendedMajor = intendedMajorTextField.text
            user.address = addressTextField.text
            user.location = cityTextField.text
        }
        
        if allFieldsFilled {
            if !saveUser() {
                saveDetailsLabel.text = "Error Updating Details"
            } else {
                parentVC.detailsUpdated = true
                dismissViewControllerAnimated(true, completion: nil)
            }
        } else {
            saveDetailsLabel.text = "Not all fields have been filled out!"
        }
    }
    
    func saveUser() -> Bool {
        let managedContext = user.managedObjectContext!
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
            return false
        }
        println("User Context Saved (or it should be?)")
        
        return true
    }

}
