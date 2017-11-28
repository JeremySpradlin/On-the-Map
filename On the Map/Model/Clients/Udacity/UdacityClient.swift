//
//  UdacityClient.swift
//  On the Map
//
//  Created by Jeremy Spradlin on 11/28/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation

class UdacityClient: NSObject {
    
    //Shared Session
    var session = URLSession.shared
    
    //Authentication variables
    var sessionID: String? = nil
    
    override init() {
        super.init()
    }
    
    func getSessionID(uName: String, pWord: String){
        var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(uName)\", \"password\": \"\(pWord)\"}}".data(using: .utf8)

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
    }
    
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
}
