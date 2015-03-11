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
    var mapBorder: UIView!
    
    var annotationView: MKAnnotationView!
    
    @IBOutlet weak var schoolMapView: MKMapView!
    
    @IBOutlet weak var selectedSchoolLabel: UILabel!
    @IBOutlet weak var selectedSchoolLocationLabel: UILabel!
    
    
    //DESELECTING THE ANNOTATION SHOULD REMOVE THE TEXT LABELS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "School Search"
        let managedContext = user.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: "School")
        var error:NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [School]?
        
        if let results = fetchedResults {
            schools = results
            for school in schools {
                let schoolCoordinates = CLLocationCoordinate2D(latitude: school.latitude as CLLocationDegrees, longitude: school.longitude as CLLocationDegrees)
                let schoolAnnotation = CustomPointAnnotation()
                schoolAnnotation.school = school
                schoolAnnotation.setCoordinate(schoolCoordinates)
                schoolAnnotation.title = "\(school.schoolName)"
                //schoolAnnotation.subtitle  = "\(school.location)"
                schoolAnnotation.imageName = "\(school.athleticConference)"
                schoolMapView.addAnnotation(schoolAnnotation)
            }
        }
        
        mapBorder = UIView(frame: CGRect(x: 12, y: 178, width: 351, height: 473))
        mapBorder.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        mapBorder.layer.cornerRadius = 7.5
        schoolMapView.layer.cornerRadius = 7.5
        self.view.addSubview(mapBorder)
        self.view.bringSubviewToFront(schoolMapView)
        
        
        selectedSchoolLabel.text = ""
        selectedSchoolLocationLabel.text = ""
        
        let madisonLocation = CLLocationCoordinate2D(latitude: 43.076592, longitude:   -89.412487)
        let span = MKCoordinateSpanMake(15, 15)
        let madisonRegion = MKCoordinateRegion(center: madisonLocation, span: span)
        schoolMapView.setRegion(madisonRegion, animated: true)
       
    }

    
    /* Imported, figure this out! */
    // @ROYALTY - The images in these annotations are not royalty free  
    
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
        annotationView.image = UIImage(named: cpa.imageName)
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        selectedSchoolLabel.text = view.annotation.title
        //selectedSchoolLocationLabel.text = view.annotation.subtitle
    }
    
    func mapView(mapView: MKMapView!, didDeselectAnnotationView view: MKAnnotationView!) {
        selectedSchoolLabel.text = ""
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        selectedSchoolLabel.text = ""
        selectedSchoolLabel.text = ""
        schoolMapView.selectAnnotation(nil, animated: false)
    }

    /**!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    *   The school added is messed up with the labeling and selecting
    *   It should add the selected school, not the label!!!
    */
    
    @IBAction func addSchoolTapped(sender: AnyObject) {
        if schoolMapView.selectedAnnotations?.first? != nil {
            var selectedSchoolAnnotation = schoolMapView.selectedAnnotations?.first! as CustomPointAnnotation
            var selectedSchool = selectedSchoolAnnotation.school

            //Casting as Mutable sets so it can update!
            // Probably should do this in core data
            let schoolViewController = storyboard?.instantiateViewControllerWithIdentifier("SchoolViewController") as SchoolViewController
            schoolViewController.school = selectedSchool
            schoolViewController.user = user
            navigationController?.pushViewController(schoolViewController, animated: true)
            
        } else {
            selectedSchoolLabel.text = "No School selected"
        }
        
    }
    
    func refreshObjects(school: School) -> Bool {
        let managedContext = user.managedObjectContext!
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
            return false
        }
        println("User Context Saved (or it should be?)")

        return true
    }
}
