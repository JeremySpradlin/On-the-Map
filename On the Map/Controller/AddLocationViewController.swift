//
//  AddLocationViewController.swift
//  On the Map
//
//  Created by Jeremy Spradlin on 1/5/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import UIKit

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
        let vc = storyboard?.instantiateViewController(withIdentifier: "confirmLocationMapViewController")
        present(vc!, animated: true, completion: nil)
    }
    
    
}
