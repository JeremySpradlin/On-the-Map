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

        UdacityClient.sharedInstance().authenticate("spradlinjk@gmail.com", "L1lyBe!!e") { (success, error) in
            performUIUpdatesOnMain {
                if !success {
                    print("Success")
                } else {
                    print("Not success")
                    let alertController = UIAlertController(title: "iOScreator", message:
                        "Hello, world!", preferredStyle: UIAlertControllerStyle.alert)
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

