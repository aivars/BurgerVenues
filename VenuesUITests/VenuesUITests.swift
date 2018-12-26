//
//  VenuesUITests.swift
//  VenuesUITests
//
//  Created by Aivars Meijers on 23/12/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import XCTest

class VenuesUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
        // clear user defaults
        app.launchArguments.append("-reset")
        
        XCUIApplication().launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRefreshBtn() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        snapshot("01MapViewScreen")
        XCUIApplication().scrollViews.otherElements.buttons["roload"].tap()
      
    }

}
