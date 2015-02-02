//
//  School.swift
//  Accepted
//
//  Created by Philip Deisinger on 2/1/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class School: NSManagedObject {

    @NSManaged var acceptanceRate: NSNumber
    @NSManaged var attendance: NSNumber
    @NSManaged var nickName: String
    @NSManaged var schoolName: String
    @NSManaged var tuition: NSNumber
    @NSManaged var favoritedByUsers: NSSet

}
