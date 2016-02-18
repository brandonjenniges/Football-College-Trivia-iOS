//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import XCTest
@testable import FootballCollegeTrivia

class PlayerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_init() {
        let count = Player.getAllPlayers().count
        XCTAssert(count > 0)
    }
    
    func test_allPlayers() {
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
    
    func test_arrayShuffle() {
        var players = Player.getAllPlayers()
        let player = players[0]
        var player2 = players[0]
        XCTAssert(player.getDisplayText() == player2.getDisplayText(), "Expected players to be equal")
        players.shuffle()
        player2 = players[0]
        XCTAssert(player.getDisplayText() != player2.getDisplayText(), "Expected players to be different")
    }
    
}
