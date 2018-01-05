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
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var addPinButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
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
    
    //Mark: mapView functions
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
        print("annotation clicked")
        UIApplication.shared.open(NSURL(string: url!!)! as URL, options: [:], completionHandler: nil)

    }
    
    //Mark: IBAction Functions
    //logoutButtonTapped - This function will activate once the lgout button is pressed.  If logout is successful it will dismiss the the tab view controller
    @IBAction func logOutButtonTapped(_ sender: Any) {
        logoutButton.isEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        UdacityClient.sharedInstance().taskForDeleteMethod(){ (success, error) in
            if !success {
                self.dismiss(animated: true, completion: nil)
            } else {
                performUIUpdatesOnMain {
                    self.logoutButton.isEnabled = true
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
                self.displayError(errorTitle: "Error", errorString: "Unable to log out")
            }
        }
    }

    @IBAction func addPinButtonTapped(_ sender: Any) {
        print("Add pin button tapped!")
        let vc = storyboard?.instantiateViewController(withIdentifier: "addLocationNavController") as! UINavigationController
        present(vc, animated: true)
    }
    
    //Function will take in a string and report an error message alert to the user
    func displayError(errorTitle: String, errorString: String) {
        let alertController = UIAlertController(title: errorTitle, message:
            errorString, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
