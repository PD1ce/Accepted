//
//  Accepted.swift
//  Accepted
//
//  Created by Philip Deisinger on 2/5/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class School: NSManagedObject {

    @NSManaged var acceptanceRate: NSNumber
    @NSManaged var athleticDivision: String
    @NSManaged var attendance: NSNumber
    @NSManaged var colors: String
    @NSManaged var establishedDate: NSNumber
    @NSManaged var latitude: NSNumber
    @NSManaged var location: String
    @NSManaged var logoName: String
    @NSManaged var longitude: NSNumber
    @NSManaged var mascot: String
    @NSManaged var motto: String
    @NSManaged var nickName: String
    @NSManaged var presidentOrChancellor: String
    @NSManaged var schoolName: String
    @NSManaged var studentsPostgrad: NSNumber
    @NSManaged var studentsTotal: NSNumber
    @NSManaged var studentsUndergrad: NSNumber
    @NSManaged var tuition: NSNumber
    @NSManaged var tuitionUndergrad: NSNumber
    @NSManaged var varsityTeams: NSNumber
    @NSManaged var website: String
    
    @NSManaged var dream: NSSet
    @NSManaged var favoritedByUsers: NSSet

}
