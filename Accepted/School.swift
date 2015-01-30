//
//  Schools.swift
//  santasWorkshop
//
//  Created by Philip Deisinger on 1/28/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation

class School {
    let schoolName:String
    let nickName:String
    let attendance:Int
    let locationX:Float
    let locationY:Float
    let majorsOffered:[Major]
    let tuition:Int
    let acceptanceRate:Float
    
    func getSchoolName() -> String { return schoolName }
    func getNickName()   -> String { return nickName }
    func getAttendance() -> Int    { return attendance }
    
    init(schoolName:String, nickName:String, attendance:Int, locationX:Float, locationY:Float, majorsOffered:[Major], tuition:Int, acceptanceRate:Float) {
        self.schoolName     = schoolName
        self.nickName       = nickName
        self.attendance     = attendance
        self.locationX      = locationX
        self.locationY      = locationY
        self.majorsOffered  = majorsOffered
        self.tuition        = tuition
        self.acceptanceRate = acceptanceRate
    }
    
}