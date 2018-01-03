//
//  TableViewController.swift
//  On the Map
//
//  Created by Jeremy Spradlin on 12/27/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Set tableview data source
    let locations = DataSource.sharedInstance.locations
    
    //IBoutlet Declarations
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var logoutButton: UIButton!
    
//    override func viewDidLoad() {
//        print("Locations count is " + String(locations.count))
//        print("Original data source count is " + String(DataSource.sharedInstance.locations.count))
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataSource.sharedInstance.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell")
        let location = DataSource.sharedInstance.locations[(indexPath as NSIndexPath).row]
        cell?.textLabel?.text = location.firstName + " " + location.lastName
        return cell!
    }
    
    
    
    //Function will take in a string and report an error message alert to the user
    func displayError(errorTitle: String, errorString: String) {
        let alertController = UIAlertController(title: errorTitle, message:
            errorString, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        logoutButton.isEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        UdacityClient.sharedInstance().taskForDeleteMethod(){ (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.logoutButton.isEnabled = true
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                self.displayError(errorTitle: "Error", errorString: "Unable to log out")
            }
        }
    }
    
    
}
