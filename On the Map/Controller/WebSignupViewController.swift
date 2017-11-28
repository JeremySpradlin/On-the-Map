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
    
    var urlRequest: URLRequest? = nil
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Inside viewWillAppear")
        
        if let urlRequest = urlRequest {
            print("Inside if statement")
            print(urlRequest)
            webView.loadRequest(urlRequest)
        }
    }
}

