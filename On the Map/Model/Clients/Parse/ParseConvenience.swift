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
    func getStudentLocations(completionHandlerForStudentLocations: @escaping (_ success: Bool, _ error: String?) -> Void) {
        
        let students = ParseClient.sharedInstance().taskForGETMethod() { (result, error) in
            
            //Display Error Function
            func displayError(_ error: String){
                print(error)
                return
            }
            
            //Guard Functions
            if error != nil {
                displayError("Error is not nil")
                completionHandlerForStudentLocations(false, "Error is not nil")
            }
            guard let results = result?["results"] as? [[String:Any]] else {
                displayError("Unable to find results in result")
                completionHandlerForStudentLocations(false, "Unable to find results in result")
                return
            }
            //For loop to cycle through for each JSONOBject in results and add the JSONObject to the array stored in the data source
            for JSONObject in results {
                let location: StudentInformation = StudentInformation(location: JSONObject as [String:Any])
                if location.firstName != "" {
                    DataSource.sharedInstance.locations = [location]
                }
            }
            completionHandlerForStudentLocations(true, nil)
        }
    }
}
