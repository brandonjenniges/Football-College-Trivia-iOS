//
//  FootballCollegeTriviaUITests.swift
//  FootballCollegeTriviaUITests
//
//  Created by Brandon Jenniges on 12/3/15.
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import XCTest

class FootballCollegeTriviaUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        
        let app = XCUIApplication()
        setLanguage(app)
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testScreenshotHome() {
        snapshot("01HomeScreen")
    }
    
    func testScreenshotDifficultySelector() {
        XCUIApplication().buttons["Standard"].tap()
        snapshot("02Difficulty")
    }
    
    func testScreenshotGameplay() {
        let app = XCUIApplication()
        XCUIApplication().buttons["Standard"].tap()
        app.sheets["Choose a difficulty"].collectionViews.buttons["Rookie"].tap()
        app.buttons.elementBoundByIndex(4).tap()
        snapshot("03Game")
    }
}
