//
//  UnitTests.swift
//  VenuesTests
//
//  Created by Aivars Meijers on 23/12/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import Foundation
import XCTest
import CoreLocation

@testable import Venues

class LocationUnitTests: XCTestCase {
    
    let homeViewControler = HomeViewController()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDistanceCalculations(){
        let result = homeViewControler.distance(from: CLLocationCoordinate2D(latitude: 58.3780, longitude: 26.7321), to: CLLocationCoordinate2D(latitude: 58.3780, longitude: 26.7321))
        let expected = 0.0
        XCTAssertEqual(result, expected)
        
    }
}
