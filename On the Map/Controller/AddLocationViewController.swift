//
//  AddLocationViewController.swift
//  On the Map
//
//  Created by Jeremy Spradlin on 1/5/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit


class AddLocationViewController: UIViewController {
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
    //Mark: Outlet Declarations
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var URLTextField: UITextField!
    @IBOutlet weak var findLocationButton: UIButton!
    
    
    
    
    
    
    //Mark: IB Action Functions
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func findLocationButtonTapped(_ sender: Any) {
        
        let studentURL = "www.google.com"
        let address = "United States, Coral Springs, Florida"
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "confirmLocationMapViewController") as! ConfirmLocationViewController
        vc.address = address
        vc.studentURL = studentURL
        present(vc, animated: true, completion: nil)
    }
    
}
