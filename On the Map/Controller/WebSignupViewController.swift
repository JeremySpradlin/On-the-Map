//
//  signupWebViewController.swift
//  On the Map
//
//  Created by Jeremy Spradlin on 11/27/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation
import UIKit

class WebSignupViewController: UIViewController {
    
    //MARK: Variable Declarations
    var urlRequest: URLRequest? = nil
    
    //MARK: IBOutlet Declarations
    @IBOutlet weak var webView: UIWebView!
    
    //MARK: Override Functions
    //viewWillAppear will load the signup web page when the view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let urlRequest = urlRequest {
            webView.loadRequest(urlRequest)
        }
    }
    
    //MARK: IBActions
    //Cancel button will dismiss the web view controller when pressed
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

