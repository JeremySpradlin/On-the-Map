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
    var accountKey: String? = nil
    var firstName: String? = nil
    var lastName: String? = nil
    
    override init() {
        super.init()
    }
    
    //Mark:  taskForPostMethod
    func taskForPostMethod(_ uName:String, _ pWord:String, completionHandlerForPost: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {

        // 1/2/3. Build URL and configure the request
        var request = URLRequest(url: URL(string: "https://www.udacity.com/api/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(uName)\", \"password\": \"\(pWord)\"}}".data(using: .utf8)

        // 4. Make the request
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in

            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPost(nil, NSError(domain: "taskForPostMethod", code: 1, userInfo: userInfo))
            }

            //Guard: Was there an error?
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }

            //Guard: Did we get a successfull 2XX response?
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2XX")
                return
            }

            //Guard: Was there any data retunred?
            guard let data = data else {
                sendError("No data was returned by the request")
                return
            }

        // 5/6. Parse the data and use the data
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range)

            var parsedResult: [String:AnyObject]! = nil
            do {
                parsedResult = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as! [String:AnyObject]
            } catch {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
                sendError("Could not parse the data as JSON: '\(data)'")
                completionHandlerForPost(nil, NSError(domain: "getUserInfo", code: 1, userInfo: userInfo))
                return
            }
            completionHandlerForPost(parsedResult as AnyObject, nil)
        }

        // 7. Start the request
        task.resume()
        return task
    }
    //Mark: taskForGetMethod
    func taskForGetMethod(_ accountKey: String, completionHandlerForGet: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void ) -> URLSessionDataTask{
        
        // 1/2/3. Build URL and configure the request
        let request = URLRequest(url: URL(string: "https://www.udacity.com/api/users/\(accountKey)")!)
        let session = URLSession.shared
        
        // 4. Make the request
        let task = session.dataTask(with: request) {data, response, error in
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGet(nil, NSError(domain: "taskForPostMethod", code: 1, userInfo: userInfo))
            }
            
            //Guard: Was there an error?
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            //Guard: Did we get a successfull 2XX response?
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2XX")
                return
            }
            
            //Guard: Was there any data retunred?
            guard let data = data else {
                sendError("No data was returned by the request")
                return
            }
            
            // 5/6. Parse the data and use the data
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range)
            
            var parsedResult: [String:AnyObject]! = nil
            do {
                parsedResult = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as! [String:AnyObject]
            } catch {
                let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
                sendError("Could not parse the data as JSON: '\(data)'")
                completionHandlerForGet(nil, NSError(domain: "getUserInfo", code: 1, userInfo: userInfo))
                return
            }
            completionHandlerForGet(parsedResult as AnyObject, nil)
        }
        task.resume()
        return task
    }
    
    
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
}
