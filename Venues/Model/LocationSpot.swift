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
