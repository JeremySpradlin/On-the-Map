//
//  MapKitViewController.swift
//  On the Map
//
//  Created by Jeremy Spradlin on 12/21/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit
import MapKit

class MapKitViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.setCenter(self.mapView.region.center, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        createPins()
    }
    
    //Mark: Create the location pins and place them on the map
    func createPins() {
        
        let locations = DataSource.sharedInstance.locations
        for location in locations {
            
            let lat = CLLocationDegrees(location.latitude)
            let long = CLLocationDegrees(location.longitude)
            let coord = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coord
            let userName = location.firstName + " " + location.lastName
            annotation.title = userName
            annotation.subtitle = location.mediaURL
            mapView.addAnnotation(annotation)
            
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var pin = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKPinAnnotationView

        if pin == nil {
            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            pin?.canShowCallout = true
            pin?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pin?.annotation = annotation
        }

        return pin
    }
    
    
    //Mark:  Open location annotation link in safari.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let url = view.annotation?.subtitle
    }
    
}
