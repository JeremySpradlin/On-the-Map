//
//  ConfirmLocationViewController.swift
//  On the Map
//
//  Created by Jeremy Spradlin on 1/5/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import UIKit

class ConfirmLocationViewController: UIViewController {
    
    //Mark: Outlet Declarations
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    
    
    //Mark: IBAction Functions
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func finishButtonTapped(_ sender: Any) {
        print("finishButtonTapped")
    }
    
    
}
