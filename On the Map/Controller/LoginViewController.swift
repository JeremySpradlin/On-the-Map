//
//  ViewController.swift
//  On the Map
//
//  Created by Jeremy Spradlin on 11/24/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: Outlet Declarations
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    
    
    
    //MARK: Button Actions
    @IBAction func loginButton(_ sender: Any) {

        UdacityClient.sharedInstance().authenticate(usernameTextField.text!, passwordTextField.text!) { (success, error) in
            performUIUpdatesOnMain {
                if success {
                    //TODO: need to add checks in for textfields/textfield delegates
                    // Add checks to determine whether or not internet connection exist
                    // Add activity monitor?
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "OnTheMapVC") as! UITabBarController
                    self.present(vc, animated: true)
                    ParseClient.sharedInstance().getStudentLocations()
                    //TODO: Need to move to separate function for testing if method succeeds before loading tableview and map
                    //Also need to move opening the tab view controller to the new function as well.

                } else {
                    let alertController = UIAlertController(title: "Login Failed", message:
                        "Please check Username and Password and try again.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))

                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    @IBAction func signupButton(_ sender: Any) {
        let signupURL = URL(string: "https://auth.udacity.com/sign-up?")
        let request = URLRequest(url: signupURL!)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebSignupViewController") as! WebSignupViewController
        
        vc.urlRequest = request
        present(vc, animated: true, completion: nil)
    }
    

}

