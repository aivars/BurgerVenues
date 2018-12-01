//
//  LocationSpot.swift
//  Venues
//
//  Created by Aivars Meijers on 24/11/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class LocationSpot: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
    }
    
    var subtitle: String? {
        return locationName
    }
    
    func mapItem(location: CLLocationCoordinate2D) -> MKMapItem {
        let addressDictionary = [String(CNPostalAddressStreetKey):subtitle]
        let placemark = MKPlacemark(coordinate: location, addressDictionary: addressDictionary as [String : Any])
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    

}
