//
//  Copyright © 2015-2016 Brandon Jenniges. All rights reserved.
//

import XCTest
@testable import FootballCollegeTrivia

class CollegeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_init() {
        let count = College.getAllColleges().count
        XCTAssert(count > 0)
    }
    
    func test_collegeData() {
        for college in College.getAllColleges() {
            XCTAssert(!college.name.isEmpty)
            XCTAssert(college.tier > 0 && college.tier < 4)
        }
    }
    
    func test_tierOneColleges() {
        for college in College.getTierOneColleges() {
            XCTAssert(college.tier == 1)
        }
    }
    
    func test_tierTwoColleges() {
        for college in College.getTierTwoColleges() {
            XCTAssert(college.tier == 2)
        }
    }
    
    func test_tierThreeColleges() {
        for college in College.getTierThreeColleges() {
            XCTAssert(college.tier == 3)
        }
    }
    
    func test_singleCreate() {
        XCTAssert(College.getTierOneColleges() == College.getTierOneColleges())
        XCTAssert(College.getTierTwoColleges() == College.getTierTwoColleges())
        XCTAssert(College.getTierThreeColleges() == College.getTierThreeColleges())
    }
    
    func test_equality() {
        let college1 = College.getTierOneColleges()[0]
        let college2 = College.getTierOneColleges()[0]
        let differentCollege = College.getTierOneColleges()[1]

        XCTAssert(college1 == college2, "Colleges weren't equal")
        XCTAssert(college1 != differentCollege, "Colleges weren't supposed to be equal")
    }
    
    func test_getCollegesForTier() {
        var tier = 1
        XCTAssert(College.getTierOneColleges() == College.getCollegesForTier(tier), "Expected arrays to be equal using tier: \(tier)")
        tier = 2
        XCTAssert(College.getTierTwoColleges() == College.getCollegesForTier(tier), "Expected arrays to be equal using tier: \(tier)")
        tier = 3
        XCTAssert(College.getTierThreeColleges() == College.getCollegesForTier(tier), "Expected arrays to be equal using tier: \(tier)")
    }
    
    func test_getCurrentArrayForTier() {
        var tier = 1
        XCTAssert(College.getTierOneColleges() == College.getCurrentArray(tier), "Expected arrays to be equal using tier: \(tier)")
        tier = 2
        XCTAssert(College.getTierTwoColleges() == College.getCurrentArray(tier), "Expected arrays to be equal using tier: \(tier)")
        tier = 3
        XCTAssert(College.getTierThreeColleges() == College.getCurrentArray(tier), "Expected arrays to be equal using tier: \(tier)")
        
    }
}
