//
//  Constants.swift
//  Venues
//
//  Created by Aivars Meijers on 26/12/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import Foundation
import CoreLocation

struct Constants {
    struct Foursquare {
        static let clientId = "SKFVFAJQOCZ4SBO4UWWTAW21JB2YE2FVH0BCZRPYFILW2HV1"
        static let clientSecret = "0C5B3OPU4DFMOBA2ZTO3LPKGBIM00ZY5ZYVOAJHRGPZQOJWG"
    }
    
    struct Locations {
        static let tartuBusStationloc = CLLocationCoordinate2D(latitude: 58.3780, longitude: 26.7321)
    }
    
    struct Urls {
        static let burgerApiUrl = "https://pplkdijj76.execute-api.eu-west-1.amazonaws.com/prod/recognize"
    }
    
}
