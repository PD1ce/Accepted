//
//  StarRating.swift
//  Accepted
//
//  Created by Philip Deisinger on 2/24/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit

class StarRating : UIView {
    
    var stars: [UIImageView]!
    let starred = UIImage(named: "favSchoolYes")
    let unstarred = UIImage(named: "favSchoolNo")
    var rating: Float!
    var name: String!
    
    //Width is 160 for these ratings currently
    init(frame: CGRect, name: String) {
        super.init(frame: frame)
        rating = 0
        self.name = name
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1).CGColor
        self.layer.borderWidth = 2.0
        self.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        stars = [UIImageView]()
        for var i = 0; i < 5; i++ {
            let image = UIImageView(image: unstarred)
            image.frame = CGRect(x: (i * 30) + 5, y: 5, width: 30, height: 30)
            stars.append(image)
            self.addSubview(image)
        }
    }
    
    func initialRatingUpdate(rating: Float) {
        if rating == 0 {
            for star in stars {
                star.image = unstarred
            }
            self.rating = 0
        } else if rating == 1 {
            stars[0].image = starred
            stars[1].image = unstarred
            stars[2].image = unstarred
            stars[3].image = unstarred
            stars[4].image = unstarred
            self.rating = 1
        } else if rating == 2 {
            stars[0].image = starred
            stars[1].image = starred
            stars[2].image = unstarred
            stars[3].image = unstarred
            stars[4].image = unstarred
            self.rating = 2
        } else if rating == 3 {
            stars[0].image = starred
            stars[1].image = starred
            stars[2].image = starred
            stars[3].image = unstarred
            stars[4].image = unstarred
            self.rating = 3
        } else if rating == 4 {
            stars[0].image = starred
            stars[1].image = starred
            stars[2].image = starred
            stars[3].image = starred
            stars[4].image = unstarred
            self.rating = 4
        } else if rating == 5 {
            stars[0].image = starred
            stars[1].image = starred
            stars[2].image = starred
            stars[3].image = starred
            stars[4].image = starred
            self.rating = 5
        }
    }
    
    func updateRating(x: CGFloat) {
        if (x >= 0.0 && x < 29.99) {
            for star in stars {
                star.image = unstarred
            }
            rating = 0
        }
        if (x >= 30.0 && x < 59.99) {
            stars[0].image = starred
            stars[1].image = unstarred
            stars[2].image = unstarred
            stars[3].image = unstarred
            stars[4].image = unstarred
            rating = 1
        }
        if (x >= 60.0 && x < 89.99) {
            stars[0].image = starred
            stars[1].image = starred
            stars[2].image = unstarred
            stars[3].image = unstarred
            stars[4].image = unstarred
            rating = 2
        }
        if (x >= 90.0 && x < 119.99) {
            stars[0].image = starred
            stars[1].image = starred
            stars[2].image = starred
            stars[3].image = unstarred
            stars[4].image = unstarred
            rating = 3
        }
        if (x >= 120.0 && x < 149.99) {
            stars[0].image = starred
            stars[1].image = starred
            stars[2].image = starred
            stars[3].image = starred
            stars[4].image = unstarred
            rating = 4
        }
        if (x >= 150.0) {
            for star in stars {
                star.image = starred
            }
            rating = 5
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}