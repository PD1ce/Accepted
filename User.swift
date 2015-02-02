//
//  User.swift
//  Accepted
//
//  Created by Philip Deisinger on 2/1/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var age: NSNumber
    @NSManaged var email: String
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var numberOfUsers: NSNumber
    @NSManaged var password: String
    @NSManaged var username: String
    @NSManaged var favoriteSchools: NSMutableSet

}
