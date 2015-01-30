//
//  SchoolMapViewController.swift
//  santasWorkshop
//
//  Created by Philip Deisinger on 1/28/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit
import MapKit

class SchoolMapViewController: UIViewController {
    
    var madisonAnnotation: MKPointAnnotation!
    @IBOutlet weak var schoolMapView: MKMapView!
    @IBOutlet weak var selectedSchoolLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = CLLocationCoordinate2D(
            latitude: 43.0667,
            longitude: 89.4000
        )
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        schoolMapView.setRegion(region, animated: true)
        madisonAnnotation = MKPointAnnotation()
        madisonAnnotation.setCoordinate(location)
        madisonAnnotation.title = "Madison"
        madisonAnnotation.subtitle = "Wisconsin"
        
        
        schoolMapView.addAnnotation(madisonAnnotation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addSchoolTapped(sender: AnyObject) {
        if let schoolLabel = schoolMapView.selectedAnnotations?.first?.title {
            selectedSchoolLabel.text = schoolLabel
        }
        
    }
    
}
