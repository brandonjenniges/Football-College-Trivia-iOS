//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import XCTest
@testable import FootballCollegeTrivia

class PlayerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit() {
        let count = Player.getAllPlayers().count
        XCTAssert(count > 0)
    }
    
    func testAllPlayers() {
        for player in Player.getAllPlayers() {
            XCTAssert(!player.firstName.isEmpty, "\(player)")
            XCTAssert(!player.lastName.isEmpty, "\(player)")
            XCTAssert(!player.proTeam.isEmpty, "\(player)")
            XCTAssert(!player.position.isEmpty, "\(player)")
            XCTAssert(player.jerseyNumber > 0 && player.jerseyNumber < 100, "\(player)")
            XCTAssert(player.overall > 0 && player.overall <= 100, "\(player)")
            XCTAssert(!player.college.isEmpty, "\(player)")
            XCTAssert(player.tier > 0 && player.tier < 4, "\(player)")
        }
    }
    
}
