//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import XCTest
@testable import FootballCollegeTrivia

class GamePresenterTests: XCTestCase {
    
    var viewController: GameViewController!
    var presenter:GamePresenter!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewControllerWithIdentifier(GameViewController.storyboardId) as! GameViewController
        presenter = GamePresenter(view: viewController, difficulty: .Rookie, gameType: .Standard)
        viewController.presenter = presenter
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_init() {
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(presenter)
    }
    
}
