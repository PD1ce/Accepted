//
//  Accepted.swift
//  Accepted
//
//  Created by Philip Deisinger on 2/20/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class Accepted: NSManagedObject {

    @NSManaged var acceptanceRate: NSNumber
    @NSManaged var athleticConference: String
    @NSManaged var attendance: NSNumber
    @NSManaged var city: String
    @NSManaged var colors: String
    @NSManaged var endowment: String
    @NSManaged var establishedDate: NSNumber
    @NSManaged var inStateTuition: NSNumber
    @NSManaged var latitude: NSNumber
    @NSManaged var location: String
    @NSManaged var logoName: String
    @NSManaged var longitude: NSNumber
    @NSManaged var mascot: String
    @NSManaged var motto: String
    @NSManaged var nickName: String
    @NSManaged var outOfStateTuition: NSNumber
    @NSManaged var presidentOrChancellor: String
    @NSManaged var publicPrivate: String
    @NSManaged var schoolName: String
    @NSManaged var state: String
    @NSManaged var studentsPostgrad: NSNumber
    @NSManaged var studentsTotal: NSNumber
    @NSManaged var studentsUndergrad: NSNumber
    @NSManaged var tuitionGrad: NSNumber
    @NSManaged var tuitionUndergrad: NSNumber
    @NSManaged var usNewsRanking: NSNumber
    @NSManaged var varsityTeams: NSNumber
    @NSManaged var website: String
    @NSManaged var primaryRed: NSNumber
    @NSManaged var primaryGreen: NSNumber
    @NSManaged var primaryBlue: NSNumber
    @NSManaged var secondaryRed: NSNumber
    @NSManaged var secondaryGreen: NSNumber
    @NSManaged var secondaryBlue: NSNumber
    @NSManaged var dream: NSSet
    @NSManaged var favoritedByUsers: NSSet

}
