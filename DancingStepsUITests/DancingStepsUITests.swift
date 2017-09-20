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
    
    /* IMPORTANT TO NOTE: To run this test successfully:
        - The app must be installed in a real device.
        - The app must not exist in the real device used before the UI test.
        - Last time tested (31st August 17): iOS 10, iPhone 7
     */
    func testRecordActionAndCheckVideoList() {
        
        // ------- FIRST STEP: Record the video ---------
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Record"].tap()
        
        //app.alerts["“DancingSteps” Would Like to Access the Camera"].buttons["Allow"].tap()
        
        addUIInterruptionMonitor(withDescription: "Camera & Microphone Services") { (alert) -> Bool in
            alert.buttons["OK"].tap()
            return true
        }
        
        app.buttons["startRecording"].tap()
        app.buttons["stopRecording"].tap()
        
        let setANameForYourVideoTextField = app.textFields["Set a name for your video !"]
        setANameForYourVideoTextField.tap()
        setANameForYourVideoTextField.typeText("Testing")
        app.buttons["Save video !"].tap()
        
        XCTAssertTrue(app.alerts[""].exists)
        app.alerts.buttons["OK"].tap()
        
        // ------- SECOND STEP: Check the video ---------
        tabBarsQuery.buttons["Videos"].tap()
        let tablesQuery = app.tables
        tablesQuery.cells.containing(.staticText, identifier:"Testing").children(matching: .staticText).matching(identifier: "Testing").element(boundBy: 0).tap()
        
        let shareButton = app.navigationBars["DancingSteps.DisplayView"].buttons["Share"]
        shareButton.tap()
        
        let collectionViewsQuery = app.collectionViews.collectionViews
        XCTAssertTrue(collectionViewsQuery.buttons["WhatsApp"].exists)
    }
    
}
