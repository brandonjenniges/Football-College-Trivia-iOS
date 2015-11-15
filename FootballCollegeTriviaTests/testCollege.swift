//
//  Copyright © 2014-2015 Brandon Jenniges. All rights reserved.
//

import XCTest

class testCollege: XCTestCase {

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

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
