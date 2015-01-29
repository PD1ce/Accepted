//
//  User.swift
//  santasWorkshop
//
//  Created by Philip Deisinger on 1/28/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation

class User {
    struct Static {
        static var numberOfUsers:Int = 0
    }
    
    let username:String!
    let firstName:String!
    let lastName:String!
    var password:String!
    var email:String!
    var age:Int!
    var major:Major!
    
    var location:Location!
    
    var favoriteSchools:[School]!
    
}
