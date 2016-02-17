//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import XCTest
@testable import FootballCollegeTrivia

class ResultsViewControllerTests: XCTestCase {
    
    var viewController: ResultsViewController!
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewControllerWithIdentifier(ResultsViewController.storyboardId) as! ResultsViewController
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_init() {
        XCTAssertNotNil(viewController)
    }
    
    func test_scoreSet() {
        viewController.score = 100
        let _ = viewController.view

        XCTAssertEqual(viewController.scoreLabel.text, "Score: \(100)")
    }
    
    func test_returnHome() {
        // Get title scren
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let titleViewController = storyboard.instantiateViewControllerWithIdentifier(String(TitleViewController))
        
        // Create navigation stack
        let navigationController = UINavigationController(rootViewController: titleViewController)
        
        // Supply navigation stack with data
        let vc = [titleViewController, viewController]
        navigationController.viewControllers = vc
        
        viewController.returnHome(self)
        
        XCTAssert(navigationController.viewControllers.count == 1, "Expected 1 but actual was \(navigationController.viewControllers.count)")
    }
    
    func test_playAgain() {
        // Get title scren
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let titleViewController = storyboard.instantiateViewControllerWithIdentifier(String(TitleViewController))
        
        // Get game scren
        let gameViewController = storyboard.instantiateViewControllerWithIdentifier(String(GameViewController))
        
        // Create navigation stack
        let navigationController = UINavigationController(rootViewController: titleViewController)
        
        // Supply navigation stack with data
        let vc = [titleViewController, gameViewController, viewController]
        navigationController.viewControllers = vc
        
        viewController.playAgain(self)
        
        let expecation = expectationWithDescription("wait")
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            print("test")
            expecation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(5) { error  in
            XCTAssert(navigationController.viewControllers.count == 2, "Expected 2 but actual was \(navigationController.viewControllers.count)")
            XCTAssert(navigationController.viewControllers.last == gameViewController, "Top view controller wasn't gameViewController")
        }
        
    }
    
    func test_ratePressed() {
        viewController.ratePressed(self)
    }
    
}
