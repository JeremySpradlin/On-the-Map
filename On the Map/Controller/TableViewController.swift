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
    
    override func viewDidLoad() {
        activityIndicator.isHidden = true
    }
    
    //Mark: Tableview Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataSource.sharedInstance.locations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell") as? StudentLocationCell
        let location = DataSource.sharedInstance.locations[(indexPath as NSIndexPath).row]
        cell?.studentNameLabel.text = location.firstName + " " + location.lastName
        //cell?.studentURLLabel.text = location.mediaURL
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = DataSource.sharedInstance.locations[indexPath.row].mediaURL
        if url.contains("https://") || url.contains("http://") {
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        } else {
            displayError(errorTitle: "Invalid URL", errorString: "URL is not formatted correctly!")
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    //Function will take in a string and report an error message alert to the user
    func displayError(errorTitle: String, errorString: String) {
        let alertController = UIAlertController(title: errorTitle, message:
            errorString, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Mark: IBAction Functions
    //logoutButtonTapped - This function will activate once the lgout button is pressed.  If logout is successful it will dismiss the the tab view controller
    @IBAction func logoutButtonTapped(_ sender: Any) {
        logoutButton.isEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        UdacityClient.sharedInstance().taskForDeleteMethod(){ (success, error) in
            if success {
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
        let vc = storyboard?.instantiateViewController(withIdentifier: "addLocationViewController")
        present(vc!, animated: true)
    }
    
    
}
