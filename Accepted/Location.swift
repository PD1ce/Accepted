//
//  Location.swift
//  santasWorkshop
//
//  Created by Philip Deisinger on 1/28/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation

class Location {
    var xDegreeCoordinate:Float
    var xMinuteCoordinate:Float
    var xSecondCoordinate:Float
    var yDegreeCoordinate:Float
    var yMinuteCoordinate:Float
    var ySecondCoordinate:Float
    
    init (xDegreeCoordinate:Float, xMinuteCoordinate:Float, xSecondCoordinate:Float, yDegreeCoordinate:Float, yMinuteCoordinate:Float, ySecondCoordinate:Float) {
        self.xDegreeCoordinate = xDegreeCoordinate
        self.xMinuteCoordinate = xMinuteCoordinate
        self.xSecondCoordinate = xSecondCoordinate
        self.yDegreeCoordinate = yDegreeCoordinate
        self.yMinuteCoordinate = yMinuteCoordinate
        self.ySecondCoordinate = ySecondCoordinate
    }
}