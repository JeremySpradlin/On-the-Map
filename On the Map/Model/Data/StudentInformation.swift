//
//  StudentLocation.swift
//  On the Map
//
//  Created by Jeremy Spradlin on 12/25/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation

class StudentInformation {
    
    //Mark: Location Information
    var createdAt: String
    var firstName: String
    var lastName: String
    var latitude: Double
    var longitude: Double
    var mapString: String
    var mediaURL: String
    var objectId: String
    var uniqueKey: String
    var updatedAt: String
    
    
    //Mark: Initializer
    init(location: [String:Any]) {
        self.createdAt = (location["createdAt"] as? String)!
        self.firstName = (location["firstName"] as? String)!
        self.lastName = (location["lastName"] as? String)!
        self.latitude = (location["latitude"] as? Double)!
        self.longitude = (location["longitude"] as? Double)!
        self.mapString = (location["mapString"] as? String)!
        self.mediaURL = (location["mediaURL"] as? String)!
        self.objectId = (location["objectId"] as? String)!
        self.uniqueKey = (location["uniqueKey"] as? String)!
        self.updatedAt = (location["updatedAt"] as? String)!
    }
}
