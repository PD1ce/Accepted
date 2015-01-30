//
//  User.swift
//  santasWorkshop
//
//  Created by Philip Deisinger on 1/28/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class User {
    struct Static {
        static var numberOfUsers:Int = 0
    }
    
    var username:String
    var password:String
    var firstName:String!
    var lastName:String!
    var email:String!
    var age:Int!
    var major:Major!

    
    var location:Location!
    
    var favoriteSchools:[NSManagedObject]!
    
    init(username:String, password:String) {
        self.username = username
        self.password = password
        Static.numberOfUsers++
    }
    
    
    
}
