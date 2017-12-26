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
    fileprivate var _locations = [StudentLocation]()
    
    var locations: [StudentLocation] {
        get {
            return _locations
        }
        set {
            _locations.append(newValue[0])
        }
    }
    
}
