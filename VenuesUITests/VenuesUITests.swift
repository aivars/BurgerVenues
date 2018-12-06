//
//  VenuesUITests.swift
//  VenuesUITests
//
//  Created by Aivars Meijers on 02/12/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import XCTest

class VenuesUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGeneralScreens() {

        let app = XCUIApplication()
        sleep(10)
        
        addUIInterruptionMonitor(withDescription: "Allow “Venues” to access your location while you are using the app?") { (alert) -> Bool in
            let alertButton = alert.buttons["Allow"]
            if alertButton.exists {
                alertButton.tap()
                return true
            }
            return false
        }
        app.tap()
        
//        app.alerts["Allow “Venues” to access your location while you are using the app?"].buttons["Allow"].tap()
        
        sleep(10)
        let scrollViewsQuery = XCUIApplication().scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery/*@START_MENU_TOKEN@*/.maps.containing(.other, identifier:"Mount Sinai West").element/*[[".maps.containing(.other, identifier:\"Empire State Building\").element",".maps.containing(.other, identifier:\"34 St–Herald Sq\").element",".maps.containing(.other, identifier:\"Madison Square Garden\").element",".maps.containing(.other, identifier:\"Macy's\").element",".maps.containing(.other, identifier:\"Grand Central Terminal\").element",".maps.containing(.other, identifier:\"Bryant Park\").element",".maps.containing(.other, identifier:\"Times Sq–42 St\").element",".maps.containing(.other, identifier:\"AMC Empire 25\").element",".maps.containing(.other, identifier:\"42 St–Port Authority Bus Terminal\").element",".maps.containing(.other, identifier:\"Javits Center\").element",".maps.containing(.other, identifier:\"Saks Fifth Avenue\").element",".maps.containing(.other, identifier:\"Times Square\").element",".maps.containing(.other, identifier:\"The Museum of Modern Art\").element",".maps.containing(.other, identifier:\"Mount Sinai West\").element"],[[[-1,13],[-1,12],[-1,11],[-1,10],[-1,9],[-1,8],[-1,7],[-1,6],[-1,5],[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        scrollViewsQuery.otherElements.containing(.image, identifier:"iPhone_Bacground").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).matching(identifier: "The Shop").element(boundBy: 0).tap()
        XCUIDevice.shared.orientation = .faceUp
        elementsQuery.buttons["roload"].tap()
        
        
        
       
       

        
        
        
        
        
        
    }

}
