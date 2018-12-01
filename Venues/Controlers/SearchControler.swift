//
//  SearchControler.swift
//  Venues
//
//  Created by Aivars Meijers on 24/11/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import UIKit
import CoreLocation

let client_id = "SKFVFAJQOCZ4SBO4UWWTAW21JB2YE2FVH0BCZRPYFILW2HV1"
let client_secret = "0C5B3OPU4DFMOBA2ZTO3LPKGBIM00ZY5ZYVOAJHRGPZQOJWG"


class SearchController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    var searchResults = [JSON]()
    let currentLocation = CLLocationCoordinate2D(latitude: 58.3780, longitude: 26.7321)
    
    func snapToPlace() {
        let url = "https://api.foursquare.com/v2/venues/search?ll=\(currentLocation.latitude),\(currentLocation.longitude)&v=20160607&intent=checkin&limit=1&radius=4000&client_id=\(client_id)&client_secret=\(client_secret)"
        
        let request = NSMutableURLRequest(url: URL(string: url)!)
        let session = URLSession.shared
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, err -> Void in
            
            var currentVenueName:String?
            
            let json = JSON(data: data!)
            currentVenueName = json["response"]["venues"][0]["name"].string
            
        })
        
        task.resume()
    }
    
    func searchForVenue() {
        let url = "https://api.foursquare.com/v2/search/recommendations?ll=\(currentLocation.latitude),\(currentLocation.longitude)&v=20160607&intent=coffee&limit=15&client_id=\(client_id)&client_secret=\(client_secret)"
        
        let request = NSMutableURLRequest(url: URL(string: url)!)
        let session = URLSession.shared
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, err -> Void in
            
            
            let json = JSON(data: data!)
            self.searchResults = json["response"]["group"]["results"].arrayValue
            
            DispatchQueue.main.async {
                for value in self.searchResults {
                    print(value)
                }
            }
            
        })
        
        task.resume()
        // populate map with results
        
    }
    
    
}

