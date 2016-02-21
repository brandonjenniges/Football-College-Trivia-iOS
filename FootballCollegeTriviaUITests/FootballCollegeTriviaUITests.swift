//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import XCTest

class FootballCollegeTriviaUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app.launchArguments = ["testMode"]
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
        app.sheets["Choose a difficulty"].collectionViews.buttons["Rookie"].tap()
    }
    
    func testScreenshotGameplay() {
        let app = XCUIApplication()
        XCUIApplication().buttons["Practice"].tap()
        app.sheets["Choose a difficulty"].collectionViews.buttons["Rookie"].tap()
        
        for _ in 1...3 {
            makeCorrectGuess()
        }
        
        snapshot("03Game")
    }
    
    func testScreenshotStandardGameplay() {
        let app = XCUIApplication()
        XCUIApplication().buttons["Standard"].tap()
        app.sheets["Choose a difficulty"].collectionViews.buttons["Rookie"].tap()
        
        for _ in 1...3 {
            makeCorrectGuess()
        }
        
        snapshot("04Game")
    }
    
    func testScreenshotDifficultGameplay() {
        let app = XCUIApplication()
        XCUIApplication().buttons["Survival"].tap()
        app.sheets["Choose a difficulty"].collectionViews.buttons["All-Pro"].tap()
        
        for _ in 1...3 {
            makeCorrectGuess()
        }
        
        snapshot("05Game")
    }
    
    func makeCorrectGuess() {
        let predicate = NSPredicate(format: "identifier == 'answer'")
        let button = app.buttons.elementMatchingPredicate(predicate)
        button.tap()
        XCTAssert(button.exists)
        sleep(1)
    }
}
