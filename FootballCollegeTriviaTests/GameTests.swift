//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import XCTest
@testable import FootballCollegeTrivia

class GameTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_stringForDifficult() {
        var difficulty: Difficulty = .Rookie
        XCTAssert(stringForDifficulty(difficulty) == "Rookie", "Expected 'Rookie' but string was \(stringForDifficulty(difficulty))")
        
        difficulty = .Starter
        XCTAssert(stringForDifficulty(difficulty) == "Starter", "Expected 'Rookie' but string was \(stringForDifficulty(difficulty))")
        
        difficulty = .Veteran
        XCTAssert(stringForDifficulty(difficulty) == "Veteran", "Expected 'Veteran' but string was \(stringForDifficulty(difficulty))")
        
        difficulty = .AllPro
        XCTAssert(stringForDifficulty(difficulty) == "All-Pro", "Expected 'All-Pro' but string was \(stringForDifficulty(difficulty))")
    }
    
    func test_getBestScoreForDifficulty() {
        saveBestScoreForDifficulty(.Rookie, score: 20)
    }
    
    func test_stringForSurvivalMode() {
        var strikes = 3
        XCTAssert(stringForSurvivalMode(strikes) == "X X X", "Expected 'X X X' but string was \(stringForSurvivalMode(strikes))")
        
        strikes = 2
        XCTAssert(stringForSurvivalMode(strikes) == "X X", "Expected 'X X' but string was \(stringForSurvivalMode(strikes))")
        
        strikes = 1
        XCTAssert(stringForSurvivalMode(strikes) == "X", "Expected 'X' but string was \(stringForSurvivalMode(strikes))")
        
        strikes = 0
        XCTAssert(stringForSurvivalMode(strikes) == "", "Expected ' ' but string was \(stringForSurvivalMode(strikes))")
    }
    
}
