//
//  ConfirmLocationViewController.swift
//  On the Map
//
//  Created by Jeremy Spradlin on 1/5/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import AddressBookUI

class ConfirmLocationViewController: UIViewController, MKMapViewDelegate {
    
    //Mark: Outlet Declarations
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    //Variable declaration for user posting
    var userID: String = DataSource.sharedInstance.sessionID
    var firstName: String = DataSource.sharedInstance.firstName
    var lastName: String = DataSource.sharedInstance.lastName
    var address: String!
    var lat: Double = 0.0
    var long: Double = 0.0
    var studentURL: String!
    var location: CLLocation?
    var placemark: CLPlacemark!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        mapView.delegate = self
        CLGeocoder().geocodeAddressString(address){ (placemark, error) in
            
            guard error == nil else {
                print("Error getting geocode address")
                return
            }
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = (placemark?.first?.location?.coordinate)!
            annotation.title = placemark?.first?.name
            
            let region = MKCoordinateRegionMake(annotation.coordinate, MKCoordinateSpanMake(0.05, 0.05))
            
            self.mapView.setRegion(region, animated: true)
            self.mapView.addAnnotation(annotation)
            
        }
        
    }

    func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        if error != nil {
            print("There was an error")
        } else {
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                let coordinate = location.coordinate
                lat = Double(location.coordinate.latitude)
                long = Double(location.coordinate.longitude)
                
            } else {
                print("No matching location found")
            }
        }
    }
    
    //Mark: mapView functions - This function will customize the look of the pin placed on the map
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

    
    //Mark: IBAction Functions
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func finishButtonTapped(_ sender: Any) {
        print("finishButtonTapped")
        
        ParseClient.sharedInstance().postUserLocation(userID, firstName, lastName, address, studentURL, lat, long) { (success, error) -> Void in
            
            if success {
                print("Successful Posting!")
            } else {
                print("Not successful Posting")
            }
            
        }
        
    }
}
