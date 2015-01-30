//
//  SchoolMapViewController.swift
//  santasWorkshop
//
//  Created by Philip Deisinger on 1/28/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class SchoolMapViewController: UIViewController, MKMapViewDelegate {
    
    var user: NSManagedObject!
    
    var madisonAnnotation:  MKPointAnnotation!
    var matcAnnotation:     MKPointAnnotation!
    
    var customMadisonAnnotation: CustomPointAnnotation!
    var customMatcAnnotation: CustomPointAnnotation!
    
    var annotationView: MKAnnotationView!
    
    @IBOutlet weak var schoolMapView: MKMapView!
    
    @IBOutlet weak var selectedSchoolLabel: UILabel!
    @IBOutlet weak var selectedSchoolLocationLabel: UILabel!
    
    
    /* Imported, figure this out! */
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if !(annotation is CustomPointAnnotation) {
            return nil
        }
        
        let reuseId = "test"
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            annotationView.canShowCallout = true
        }
        else {
            annotationView.annotation = annotation
        }
        
        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...
        
        let cpa = annotation as CustomPointAnnotation
        let cgSize = CGSize(width: 10.0, height: 10.0)
        annotationView.image = UIImage(named: cpa.imageName)
        annotationView.sizeThatFits(cgSize)
        
        return annotationView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedSchoolLabel.text = ""
        selectedSchoolLocationLabel.text = ""
        
        //annotationView = MKAnnotationView()
        //let buckyIcon = UIImageView(image: UIImage(named: "bucky-icon"))
        
        
        let madisonLocation = CLLocationCoordinate2D(latitude: 43.0667, longitude: 89.4000)
        let matcLocation = CLLocationCoordinate2D(latitude: 43.0700, longitude: 89.4010)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let madisonRegion = MKCoordinateRegion(center: madisonLocation, span: span)
        schoolMapView.setRegion(madisonRegion, animated: true)
        
        customMadisonAnnotation = CustomPointAnnotation()
        customMadisonAnnotation.setCoordinate(madisonLocation)
        customMadisonAnnotation.title = "University of Wisconsin-Madison"
        customMadisonAnnotation.subtitle = "Madison, WI"
        customMadisonAnnotation.imageName = "bucky-icon"
        
        
        
        schoolMapView.addAnnotation(customMadisonAnnotation)
        
        customMatcAnnotation = CustomPointAnnotation()

        
        
        /*
        madisonAnnotation = MKPointAnnotation()
        madisonAnnotation.setCoordinate(madisonLocation)
        madisonAnnotation.title = "University of Wisconsin-Madison"
        madisonAnnotation.subtitle = "Madison, WI"
        
        matcAnnotation = MKPointAnnotation()
        matcAnnotation.setCoordinate(matcLocation)
        matcAnnotation.title = "Madison Area Technical College"
        matcAnnotation.subtitle = "Madison, WI"

        schoolMapView.addAnnotation(madisonAnnotation)
        schoolMapView.addAnnotation(matcAnnotation)
        */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        selectedSchoolLabel.text = ""
        selectedSchoolLabel.text = ""
    }
    
    @IBAction func selectSchoolTapped(sender: AnyObject) {
        if let schoolLabel = schoolMapView.selectedAnnotations?.first?.title {
            selectedSchoolLabel.text = schoolLabel
            selectedSchoolLocationLabel.text = schoolMapView.selectedAnnotations?.first?.subtitle
        }
        
    }
    
    /**!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    *   The school added is messed up with the labeling and selecting
    *   It should add the selected school, not the label!!!
    */
    
    @IBAction func addSchoolTapped(sender: AnyObject) {
        //Update Data
        //Necessary? Just update this user?
        if schoolMapView.selectedAnnotations?.first? != nil {
            var users: [NSManagedObject]!
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            let managedContext = appDelegate.managedObjectContext!
            let fetchRequest = NSFetchRequest()
            let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: managedContext)
            fetchRequest.entity = entity
            var error: NSError?
            var fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
            
            if let results = fetchedResults {
                users = results
            }
            
            for thisUser in users! {
                if thisUser.valueForKey("username") as NSString == user.valueForKey("username") as NSString {
                    var numSchools = user.valueForKey("age") as NSInteger
                    numSchools++
                    user.setValue(numSchools, forKey: "age")
                    thisUser.setValue(numSchools, forKey: "age")
                    
                    if !managedContext.save(&error) {
                        println("Could not save \(error), \(error?.userInfo)")
                    } else {
                        selectedSchoolLabel.text = "School added!"
                        selectedSchoolLocationLabel.text = ""
                        schoolMapView.deselectAnnotation(schoolMapView.selectedAnnotations.first? as MKAnnotation, animated: true)
                        break
                    }
                }
            }
        } else {
            selectedSchoolLabel.text = "No School selected"
        }
        
        
        
    }
}
