//
//  ParseConvenience.swift
//  On the Map
//
//  Created by Jeremy Spradlin on 12/24/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation
import UIKit

extension ParseClient {
    
    //Mark: Get the location of studetns from the Parse client
    func getStudentLocations() {
        
        let students = ParseClient.sharedInstance().taskForGETMethod() { (result, error) in
            
            //Display Error Function
            func displayError(_ error: String){
                print(error)
                return
            }
            
            //Guard Functions
            if error != nil {
                displayError("Error is not nil")
            }
//            guard let result = result as? [String:Any] else {
//                displayError("Unable to find data")
//                return
//            }
            guard let results = result?["results"] as? [[String:Any]] else {
                displayError("Unable to find results in result")
                return
            }
            //print(results)
            for JSONObject in results {
                
                let location: StudentLocation = StudentLocation(location: JSONObject as [String:Any])
                if location.firstName != "" {
                    DataSource.sharedInstance.locations = [location]
                }
                
            }
            print(DataSource.sharedInstance.locations.count)
        }
        
    }
    
}
