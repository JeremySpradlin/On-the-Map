//
//  UdacityConvenience.swift
//  On the Map
//
//  Created by Jeremy Spradlin on 12/17/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation

extension UdacityClient {
    
    //Mark: Authenticate
    func authenticate(_ uName: String, _ pWord: String, completionHandlerForAuth: @escaping (_ success: Bool, _ errorString: String?) -> Void){

        let authenticate = UdacityClient.sharedInstance().taskForPOSTMethod(uName, pWord) { (result, error) in
            
            //Display Error Function
            func displayError(_ error: String){
                completionHandlerForAuth(false, error)
                print(error)
                //print(result)
                return
            }
            
            //Guard Functions
            if error != nil {
                completionHandlerForAuth(false, "Login failed, please check your username and password.")
            }
            guard let result = result as? [String:Any] else {
                displayError("Unable to find user data")
                return
            }
            guard let account = result["account"] as? [String:Any] else {
                displayError("Cannot find user account in result")
                return
            }
            guard let session = result["session"] as? [String:Any] else {
                displayError("Cannot find session in result")
                return
            }
            guard let key = account["key"] as? String else {
                displayError("Cannot find key in account")
                print(account)
                return
            }
            guard let registered = account["registered"] as? Bool else {
                displayError("Cannot find registgered in account")
                return
            }
            guard let expiration = session["expiration"] as? String else {
                displayError("Cannot find expiration in session")
                return
            }
            guard let id = session["id"] as? String else {
                displayError("Cannot find id in session")
                return
            }
            
            self.getUserinfo(key, registered, expiration, id, completionHandlerForUserInfo: completionHandlerForAuth)
        }
        
    }
    
    func getUserinfo(_ accountKey: String, _ accountRegistered: Bool, _ sessionExpiration: String, _ sessionID: String, completionHandlerForUserInfo: @escaping (_ success: Bool, _ error: String?) -> Void) {
        
        _ = UdacityClient.sharedInstance().taskForGETtMethod(accountKey) { (result, error) in
            
            //Display Error Function
            func displayError(_ error: String){
                completionHandlerForUserInfo(false, error)
                print(error)
                print(result!)
                return
            }
            
            //Guard Functions
            if error != nil {
                completionHandlerForUserInfo(false, "Error occured getting user info.")
            }
            guard let result = result as? [String:Any] else {
                displayError("Unable to find user data")
                return
            }
            guard let user = result["user"] as? [String:Any] else {
                displayError("Unable to find user in the result")
                return
            }
            guard let firstName = user["first_name"] as? String else {
                displayError("Unable to find first name in user.")
                return
            }
            guard let lastName = user["last_name"] as? String else {
                displayError("Unable to findn last name in user.")
                return
            }
            //TODO: Need to move stored information to the data source
            UdacityClient.sharedInstance().firstName = firstName
            UdacityClient.sharedInstance().lastName = lastName
            UdacityClient.sharedInstance().accountKey = accountKey
            UdacityClient.sharedInstance().sessionID = sessionID
            
            completionHandlerForUserInfo(true, nil)
            
        }
        
    }
    
}
