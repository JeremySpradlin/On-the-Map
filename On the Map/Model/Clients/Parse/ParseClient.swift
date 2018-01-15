//
//  ParseClient.swift
//  On the Map
//
//  Created by Jeremy Spradlin on 12/24/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation

class ParseClient: NSObject {
    
    //Mark: Variable Declarations
    let parseAppID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    let parseRestAPIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    let session = URLSession.shared
    


    //Mark: taskForPOSTMethod
    func taskForPOSTMethod(_ uniqueKey: String, _ firstName: String, _ lastName: String, _ mapString: String, _ mediaURL: String, _ lat: Double, _ long: Double, completionHandlerForPOST: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void ) -> URLSessionDataTask{
        
        // 1/2/3. Build the URL and configure the request
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(uniqueKey)\", \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\", \"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\", \"latitude\": \(lat), \"longitude\": \(long)}".data(using: .utf8)
        
        // 4. Make the request
        let task = session.dataTask(with: request) { data, response, error in
            
            //Error Function
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPOST(nil, NSError(domain: "taskForGetMethod", code: 1, userInfo: userInfo))
            }
            
            //Guard: Check for errors in data
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2XX")
                print((response as? HTTPURLResponse)?.statusCode)

                return
            }
            guard let data = data else {
                sendError("No data was returned by the request")
                return
            }
            
            // 5/6. Parse the data and use the data
            //print(String(data: data!, encoding: .utf8)!)
            var parsedResult: [String:AnyObject]! = nil
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
            } catch {
                print("Error parsing JSON data")
            }
            completionHandlerForPOST(parsedResult as AnyObject, nil)
            
        }
        // 7. Start Request
        task.resume()
        return task
    }
    
    //Mark: taskForGETMethod
    func taskForGETMethod(_ completionHandlerForGet: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void ) -> URLSessionDataTask{
        
        // 1/2/3. Build the URL and configure the request
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation?limit=100")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        
        // 4. Make the request
        let task = session.dataTask(with: request) { data, response, error in
            
            //Error Function
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGet(nil, NSError(domain: "taskForGetMethod", code: 1, userInfo: userInfo))
            }
            
            //Guard: Check for errors in data
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2XX")
                return
            }
            guard let data = data else {
                sendError("No data was returned by the request")
                return
            }
            
            // 5/6. Parse the data and use the data
            //print(String(data: data!, encoding: .utf8)!)
            var parsedResult: [String:AnyObject]! = nil
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
            } catch {
                print("Error parsing JSON data")
            }

            completionHandlerForGet(parsedResult as AnyObject, nil)
        }
        // 7. Start the request
        task.resume()
        return task
    }

    //Mark: taskForPutMethod
    func taskForPUTMethod(_ objectID: String,_ uniqueKey: String, _ firstName: String, _ lastName: String, _ mapString: String, _ mediaURL: String, _ lat: Double, _ long: Double, completionHandlerForPOST: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void ) -> URLSessionDataTask{
        // 1/2. Set Paramaters and build the URL
        let urlString = "https://parse.udacity.com/parse/classes/StudentLocation/\(objectID)"
        let url = URL(string: urlString)
        
        // 3. Configure the Request
        var request = URLRequest(url: url!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(uniqueKey)\", \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\", \"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\", \"latitude\": \(lat), \"longitude\": \(long)}".data(using: .utf8)
        
        // 4. Make the Request
        let task = session.dataTask(with: request) { data, response, error in
            
            //Error Function
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPOST(nil, NSError(domain: "taskForGetMethod", code: 1, userInfo: userInfo))
            }
            
            //Guard: Check for errors in data
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2XX")
                return
            }
            guard let data = data else {
                sendError("No data was returned by the request")
                return
            }
            
            // 5/6. Parse the data and use the data
            //print(String(data: data!, encoding: .utf8)!)
            var parsedResult: [String:AnyObject]! = nil
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
            } catch {
                print("Error parsing JSON data")
            }
            completionHandlerForPOST(parsedResult as AnyObject, nil)
            
        }
        // 7. Start Request
        task.resume()
        return task
    }
    
    
    class func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }

    
}
