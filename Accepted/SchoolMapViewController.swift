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
    
    var user: User!
    var schools: [School]!
    
    var annotationView: MKAnnotationView!
    
    @IBOutlet weak var schoolMapView: MKMapView!
    
    @IBOutlet weak var selectedSchoolLabel: UILabel!
    @IBOutlet weak var selectedSchoolLocationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: "School")
        var error:NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [School]?
        
        if let results = fetchedResults {
            schools = results
            for school in schools {
                let schoolCoordinates = CLLocationCoordinate2D(latitude: school.latitiude as CLLocationDegrees, longitude: school.longitude as CLLocationDegrees)
                let schoolAnnotation = CustomPointAnnotation()
                schoolAnnotation.school = school
                schoolAnnotation.setCoordinate(schoolCoordinates)
                schoolAnnotation.title = "\(school.schoolName)"
                schoolAnnotation.subtitle  = "\(school.location)"
                schoolAnnotation.imageName = "\(school.schoolName)"
                schoolMapView.addAnnotation(schoolAnnotation)
            }
        }
        
        selectedSchoolLabel.text = ""
        selectedSchoolLocationLabel.text = ""
        
        let madisonLocation = CLLocationCoordinate2D(latitude: 43.076592, longitude:   -89.412487)
        let span = MKCoordinateSpanMake(1, 1)
        let madisonRegion = MKCoordinateRegion(center: madisonLocation, span: span)
        schoolMapView.setRegion(madisonRegion, animated: true)
        
    }

    
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
    
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        selectedSchoolLabel.text = view.annotation.title
        selectedSchoolLocationLabel.text = view.annotation.subtitle
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        selectedSchoolLabel.text = ""
        selectedSchoolLabel.text = ""
    }

    /**!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    *   The school added is messed up with the labeling and selecting
    *   It should add the selected school, not the label!!!
    */
    
    @IBAction func addSchoolTapped(sender: AnyObject) {
        
        /*
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        //This will be gotten from the annotation selection!!!!!
        let school = NSEntityDescription.insertNewObjectForEntityForName("School", inManagedObjectContext: managedContext) as School
        */
        
        if schoolMapView.selectedAnnotations?.first? != nil {
            var selectedSchoolAnnotation = schoolMapView.selectedAnnotations?.first! as CustomPointAnnotation
            var selectedSchool = selectedSchoolAnnotation.school
            
            // This will save user to school and vice versa!! //
            
            //school = School() // Will be instantiated by annotation
            user.favoriteSchools.addObject(selectedSchool)
            selectedSchool.favoritedByUsers.addObject(user)
            if !refreshObjects() {
                println("Error refreshing objects!")
            } else {
                selectedSchoolLabel.text = "School added!"
                selectedSchoolLocationLabel.text = ""
                schoolMapView.deselectAnnotation(schoolMapView.selectedAnnotations.first? as MKAnnotation, animated: true)
            }
            
        } else {
            selectedSchoolLabel.text = "No School selected"
        }
        
    }
    
    func refreshObjects() -> Bool {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
            return false
        }

        return true
    }
}
