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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        mapView.showsUserLocation = true
        mapView.delegate = self
        CLGeocoder().geocodeAddressString(address){ (placemark, error) in
            
            guard error == nil else {
                self.displayError(errorTitle: "Error", errorString: "Location Not Found!")
                self.dismiss(animated: true, completion: nil)
                return
            }
            
            self.processResponse(withPlacemarks: placemark, error: error)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = (placemark?.first?.location?.coordinate)!
            annotation.title = placemark?.first?.name
            
            let region = MKCoordinateRegionMake(annotation.coordinate, MKCoordinateSpanMake(0.05, 0.05))
            
            self.mapView.setRegion(region, animated: true)
            self.mapView.addAnnotation(annotation)
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            
        }
        
    }

    func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        if error != nil {
            displayError(errorTitle: "Error", errorString: "Error getting location")
        } else {
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                lat = Double(location.coordinate.latitude)
                long = Double(location.coordinate.longitude)
            } else {
                displayError(errorTitle: "Error", errorString: "Location not found")
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
        mapView.alpha = 0.5
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        ParseClient.sharedInstance().postUserLocation(userID, firstName, lastName, address, studentURL, lat, long) { (success, error) -> Void in

            if success {
                ParseClient.sharedInstance().getStudentLocations() { (success, error) in
                    if success {
                        performUIUpdatesOnMain {
                            self.mapView.alpha = 1.0
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                        }

                    } else {
                        self.displayError(errorTitle: "Error", errorString: "Error retrieving new data")
                    }
                }
            } else {
                performUIUpdatesOnMain {
                    self.mapView.alpha = 1.0
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
                self.displayError(errorTitle: "Error", errorString: "Your location failed to post.")
            }
        }
    }
    
    //Function will take in a string and report an error message alert to the user
    func displayError(errorTitle: String, errorString: String) {
        let alertController = UIAlertController(title: errorTitle, message:
            errorString, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
