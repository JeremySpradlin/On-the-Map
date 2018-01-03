//
//  DataSource.swift
//  On the Map
//
//  Created by Jeremy Spradlin on 12/25/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation

class DataSource {
    
    //Mark: Variable Declaration
    static let sharedInstance = DataSource()
    fileprivate var _locations = [StudentInformation]()
    fileprivate var _firstName: String? = nil
    fileprivate var _lastName: String? = nil
    fileprivate var _accountKey: String? = nil
    fileprivate var _sessionID: String? = nil
    
    //Mark: Get/Sets
    //Variable declaration for getting and setting stored data
    //locations - will set and return the location data downloaded from the Parse server
    var locations: [StudentInformation] {
        get {
            return _locations
        }
        set {
            _locations.append(newValue[0])
        }
    }
    
    //firstName - will set and return the user's first name
    var firstName: String {
        get {
            return _firstName!
        }
        set {
            _firstName = newValue
        }
    }
    
    //lastName - will set and return the user's last name
    var lastName: String {
        get {
            return _lastName!
        }
        set {
            _lastName = newValue
        }
    }
    
    //accountKey - will set and return the user's account key
    var accountKey: String {
        get {
            return _accountKey!
        }
        set {
            _accountKey = newValue
        }
    }
    
    //sessionID - will set and return the user's session ID
    var sessionID: String {
        get {
            return _sessionID!
        }
        set {
            _sessionID = newValue
        }
    }
}




