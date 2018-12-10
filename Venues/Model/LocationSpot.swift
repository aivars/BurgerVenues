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
    let coordinate: CLLocationCoordinate2D
    let photoSuffix: String?

    init(title: String, coordinate: CLLocationCoordinate2D, photoSuffix: String) {
        self.title = title
        self.coordinate = coordinate
        self.photoSuffix = photoSuffix

    }

}

/*
 * Stil looks that class is right way to go
 * 1) CLLocationCoordinate2D is not usable in Codable struct
 *    Lang&Long doubles should be used instead  of CLLocationCoordinate2D
 * 2) This class inherits MKAnnotation to asociate it with location
 */
