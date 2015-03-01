//
//  User.swift
//  User
//
//  Created by Philip Deisinger on 2/25/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var address: String
    @NSManaged var age: NSNumber
    @NSManaged var email: String
    @NSManaged var firstName: String
    @NSManaged var grade: NSNumber
    @NSManaged var intendedMajor: String
    @NSManaged var lastName: String
    @NSManaged var location: String
    @NSManaged var numberOfUsers: NSNumber
    @NSManaged var password: String
    @NSManaged var username: String
    @NSManaged var dreamSchool: Accepted.School
    @NSManaged var favoriteSchools: NSSet
    @NSManaged var rating: NSSet

}
