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
        print("loginButton Pressed")
    }
    @IBAction func signupButton(_ sender: Any) {
        print("signupButton Pressed")
        let signupURL = URL(string: "https://auth.udacity.com/sign-up?")
        let request = URLRequest(url: signupURL!)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebSignupViewController") as! WebSignupViewController
        
        vc.urlRequest = request
        print("Request added to vc")
        

        
        present(vc, animated: true, completion: nil)
    }
}

