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
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var activityMonitor: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        activityMonitor.isHidden = true
    }
    
    
    
    //MARK: Button Actions
    @IBAction func loginButton(_ sender: Any) {
        
        activityMonitor.isHidden = false
        loginButton.isHidden = true
        accountLabel.isHidden = true
        signupButton.isHidden = true
        activityMonitor.startAnimating()
        usernameTextField.isEnabled = false
        passwordTextField.isEnabled = false
        
        UdacityClient.sharedInstance().authenticate(usernameTextField.text!, passwordTextField.text!) { (success, error) in
            performUIUpdatesOnMain {
                if success {
                    //TODO: need to add checks in for textfields/textfield delegates
                    // Add checks to determine whether or not internet connection exist
                    
                    ParseClient.sharedInstance().getStudentLocations() { (success, error) in
                        
                        if success {
                            print("success!")
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "OnTheMapVC") as! UITabBarController
                            self.present(vc, animated: true)
                        } else {
                            print("No success")
                        }
                    }
                } else {
                    let alertController = UIAlertController(title: "Login Failed", message:
                        "Please check Username and Password and try again.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    self.activityMonitor.stopAnimating()
                    self.activityMonitor.isHidden = true
                    self.loginButton.isHidden = false
                    self.accountLabel.isHidden = false
                    self.signupButton.isHidden = false
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

