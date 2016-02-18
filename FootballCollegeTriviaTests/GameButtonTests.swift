//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import XCTest
@testable import FootballCollegeTrivia

class GameButtonTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_correctButton() {
        let readyExpectation = expectationWithDescription("ready")
        var string = ""
        let button = UIButton()
        button.correct { () -> () in
            string = "Correct"
            readyExpectation.fulfill()
        }
        waitForExpectationsWithTimeout(3.0) { (error: NSError?) -> Void in
            XCTAssertTrue(string == "Correct", "Expected 'Correct' but value was \(string)")
        }
    }
    
    func test_incorrectButton() {
        let readyExpectation = expectationWithDescription("ready")
        var string = ""
        let button = UIButton()
        button.incorrect { () -> () in
            string = "Wrong"
            readyExpectation.fulfill()
        }
        waitForExpectationsWithTimeout(3.0) { (error: NSError?) -> Void in
            XCTAssertTrue(string == "Wrong", "Expected 'Wrong' but value was \(string)")
        }
    }
    
    func test_NonClosure() {
        let button = UIButton()
        button.correct()
        sleep(2)
        button.incorrect()
    }
    
}