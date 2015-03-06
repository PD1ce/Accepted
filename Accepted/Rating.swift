//
//  Rating.swift
//  Rating
//
//  Created by Philip Deisinger on 3/6/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class Rating: NSManagedObject {

    @NSManaged var academicFit: NSNumber
    @NSManaged var academicFitMult: NSNumber
    @NSManaged var athletics: NSNumber
    @NSManaged var athleticsMult: NSNumber
    @NSManaged var classSize: NSNumber
    @NSManaged var classSizeMult: NSNumber
    @NSManaged var cost: NSNumber
    @NSManaged var costMult: NSNumber
    @NSManaged var environment: NSNumber
    @NSManaged var environmentMult: NSNumber
    @NSManaged var food: NSNumber
    @NSManaged var foodMult: NSNumber
    @NSManaged var location: NSNumber
    @NSManaged var locationMult: NSNumber
    @NSManaged var residenceHalls: NSNumber
    @NSManaged var residenceHallsMult: NSNumber
    @NSManaged var totalScore: NSNumber
    @NSManaged var visit: NSNumber
    @NSManaged var visitMult: NSNumber
    @NSManaged var schoolName: String
    @NSManaged var username: String
    @NSManaged var id: NSNumber
    @NSManaged var school: Accepted.School
    @NSManaged var user: Accepted.User
    
    func updateTotal() {
        totalScore = Float(academicFit) + Float(athletics) + Float(classSize) + Float(cost) + Float(environment) + Float(food) + Float(location) + Float(residenceHalls) + Float(visit)
    }

}
