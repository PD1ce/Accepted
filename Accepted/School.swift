//
//  Accepted.swift
//  Accepted
//
//  Created by Philip Deisinger on 2/2/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class School: NSManagedObject {

    @NSManaged var acceptanceRate: NSNumber
    @NSManaged var attendance: NSNumber
    @NSManaged var location: String
    @NSManaged var nickName: String
    @NSManaged var schoolName: String
    @NSManaged var tuition: NSNumber
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var favoritedByUsers: NSSet

}
