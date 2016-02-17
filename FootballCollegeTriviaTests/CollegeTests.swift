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
    
    func testInit() {
        let count = College.getAllColleges().count
        XCTAssert(count > 0)
    }
    
    func testCollegeData() {
        for college in College.getAllColleges() {
            XCTAssert(!college.name.isEmpty)
            XCTAssert(college.tier > 0 && college.tier < 4)
        }
    }
    
}
