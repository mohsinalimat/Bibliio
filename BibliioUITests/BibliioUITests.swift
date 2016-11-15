//
//  BibliioUITests.swift
//  BibliioUITests
//
//  Created by Adam on 11/15/16.
//  Copyright © 2016 Adam Tecle. All rights reserved.
//

import XCTest

class BibliioUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launchEnvironment = [ "UITest": "1" ]
        setupSnapshot(app)
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTakeScreenshots() {
        XCUIDevice.shared().orientation = .portrait
        XCUIDevice.shared().orientation = .portrait
        XCUIDevice.shared().orientation = .portrait
        snapshot("1EmptyReadingList")
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["Archive"].tap()
        snapshot("2Archive")
        tabBarsQuery.buttons["Books"].tap()
        XCUIDevice.shared().orientation = .faceUp
        
        
    }
    
}
