//
//  ViewController.swift
//  On the Map
//
//  Created by Jeremy Spradlin on 11/24/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    //MARK: Outlet Declarations
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var activityMonitor: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        activityMonitor.isHidden = true
        subscribeToKeyboardNotifications()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeFromKeyboardNotifications()
    }
    
    
    
    //MARK: Button Actions
    @IBAction func loginButton(_ sender: Any) {
        
        //Start network activity animation
        self.manageLoginAnimation(shouldStart: true)
        UdacityClient.sharedInstance().authenticate(usernameTextField.text!, passwordTextField.text!) { (success, error) in
            performUIUpdatesOnMain {
                
                if self.isInternetAvailable != .notReachable {
                    if success {
                        //Start network activity animation
                        self.manageLoginAnimation(shouldStart: true)
                        //Will run the getStudentLocations function, if sucessful will take the user to the main tab view controller
                        ParseClient.sharedInstance().getStudentLocations() { (success, error) in
                            if success {
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "OnTheMapVC") as! UITabBarController
                                self.present(vc, animated: true)
                                self.manageLoginAnimation(shouldStart: false)
                            } else {
                                self.displayLoginError(errorString: "Error obtaining data from server, please try again")
                            }
                        }
                    } else {
                        self.displayLoginError(errorString: "Please check Username and Password and try again")
                    }
                } else {
                    self.displayLoginError(errorString: "Please check internet connection and try again")
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

extension LoginViewController {
    // Function will remove the login/signup buttons to prevent user from hitting multuple actions and display and start
    // the activity monitor animation | stop function will revert changes resseting the view after network activity is complete
    func manageLoginAnimation(shouldStart: Bool) {
        loginButton.isHidden = shouldStart
        accountLabel.isHidden = shouldStart
        signupButton.isHidden = shouldStart
        activityMonitor.isHidden = !shouldStart
        usernameTextField.isEnabled = !shouldStart
        passwordTextField.isEnabled = !shouldStart
        if shouldStart {
            activityMonitor.startAnimating()
        } else {
            activityMonitor.stopAnimating()
        }
    }
    
    //Function will take in a string and report an error message alert to the user
    func displayLoginError(errorString: String) {
        let alertController = UIAlertController(title: "Login Failed", message:
            errorString, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
        self.manageLoginAnimation(shouldStart: false)
    }
    
    //Functions for managing the on-screen keyboard and keyboard delegate
    @objc func keyboardWillShow(_ notification:Notification) {
        view.frame.origin.y = -getKeyboardHeight(notification)/2
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillDisappear(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
