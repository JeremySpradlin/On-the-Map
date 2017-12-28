//
//  TableViewController.swift
//  On the Map
//
//  Created by Jeremy Spradlin on 12/27/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Set tableview data source
    let locations = DataSource.sharedInstance.locations
    
//    override func viewDidLoad() {
//        print("Locations count is " + String(locations.count))
//        print("Original data source count is " + String(DataSource.sharedInstance.locations.count))
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Inside numberOfRows")
        return DataSource.sharedInstance.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell")
        let location = DataSource.sharedInstance.locations[(indexPath as NSIndexPath).row]
        print("Inside cellForRowAt")
        cell?.textLabel?.text = location.firstName + " " + location.lastName
        return cell!
    }
    
}
