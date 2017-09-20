//
//  DancingStepsUITests.swift
//  DancingStepsUITests
//
//  Created by Rodrigo López-Romero Guijarro on 31/08/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import XCTest
import Foundation

class DancingStepsUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testQueryDancingEvents() {
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Top Chart"].tap()
        
        let loadingIndicator = app.activityIndicators["topEventsIndicator"]
        XCTAssertTrue(loadingIndicator.exists)
        let notExists = NSPredicate(format: "exists == false")
        expectation(for: notExists, evaluatedWith: loadingIndicator, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(loadingIndicator.exists)
        let tablesQuery = app.tables
        tablesQuery.cells.element(boundBy: 2).tap()
        XCTAssert(app.navigationBars["Details of the event"].exists)
    }
    
}
