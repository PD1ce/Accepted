//
//  SettingsViewController.swift
//  Accepted
//
//  Created by Philip Deisinger on 2/2/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController : UIViewController {
    
    var user: User!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var majorsLabel: UILabel!
    @IBOutlet weak var dreamSchoolLabel: UILabel!
    @IBOutlet weak var numSchoolsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    override func viewWillAppear(animated: Bool) {
        if !user.username.isEmpty       { usernameLabel.text    = user.username }
        if !user.password.isEmpty       { passwordLabel.text    = user.password }
        if !user.firstName.isEmpty      { firstNameLabel.text   = user.firstName }
        if !user.lastName.isEmpty       { lastNameLabel.text    = user.lastName }
        if !user.email.isEmpty          { emailLabel.text       = user.email }
        if !user.intendedMajor.isEmpty  { majorsLabel.text      = user.intendedMajor }
        //Dream School
        numSchoolsLabel.text = "\(user.favoriteSchools.count)"
        if !user.address.isEmpty        { addressLabel.text     = user.address }
        if user.age != 0                { ageLabel.text         = "\(user.age)" }
        if user.grade != 0              { gradeLabel.text       = "\(user.grade)" }
        if !user.location.isEmpty       { cityLabel.text        = user.location }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = user.username
        //// Likely all of this will be scrapped when create account is more complete
        if !user.username.isEmpty       { usernameLabel.text    = user.username }
        if !user.password.isEmpty       { passwordLabel.text    = user.password }
        if !user.firstName.isEmpty      { firstNameLabel.text   = user.firstName }
        if !user.lastName.isEmpty       { lastNameLabel.text    = user.lastName }
        if !user.email.isEmpty          { emailLabel.text       = user.email }
        if !user.intendedMajor.isEmpty  { majorsLabel.text = user.intendedMajor }
        //Dream School
        numSchoolsLabel.text = "\(user.favoriteSchools.count)"
        if !user.address.isEmpty        { addressLabel.text     = user.address }
        if user.age != 0                { ageLabel.text         = "\(user.age)" }
        if user.grade != 0              { gradeLabel.text       = "\(user.grade)" }
        if !user.location.isEmpty       { cityLabel.text        = user.location }
    }
    
    @IBAction func updateButtonTapped(sender: AnyObject) {
        let updateUserVC = storyboard?.instantiateViewControllerWithIdentifier("UpdateUserViewController") as UpdateUserViewController
        updateUserVC.user = user
        updateUserVC.parent = self
        navigationController?.pushViewController(updateUserVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}