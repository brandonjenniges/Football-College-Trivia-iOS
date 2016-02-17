//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import XCTest
@testable import FootballCollegeTrivia

class TitleViewPresenterTests: XCTestCase {
    
    var viewController: TitleViewController!
    var presenter:TitlePresenter!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewControllerWithIdentifier(TitleViewController.storyboardId) as! TitleViewController
        presenter = TitlePresenter(view: viewController)
        viewController.presenter = presenter
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_init() {
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(presenter)
    }
    
    // MARK: - GameType selection
    
    func test_PracticeSelected() {
        presenter.gameTypeSelected(.Practice, view: UIView())
        XCTAssert(presenter.gameType == .Practice)
    }
    
    func test_StandardSelected() {
        presenter.gameTypeSelected(.Standard, view: UIView())
        XCTAssert(presenter.gameType == .Standard)
    }
    
    func test_SurvivalSelected() {
        presenter.gameTypeSelected(.Survival, view: UIView())
        XCTAssert(presenter.gameType == .Survival)
    }
    
    // MARK: - Difficuly selection
    
    func test_RookieSelected() {
        presenter.gameTypeSelected(.Practice, view: UIView())
        self.viewController.dismissViewControllerAnimated(true, completion: nil)
        
        self.presenter.difficultySelected(.Rookie)
        XCTAssert(self.presenter.difficulty == .Rookie)
    }
    
    func test_StarterSelected() {
        presenter.gameTypeSelected(.Practice, view: UIView())
        self.viewController.dismissViewControllerAnimated(true, completion: nil)
        
        presenter.difficultySelected(.Starter)
        XCTAssert(presenter.difficulty == .Starter)
    }
    func test_VeteranSelected() {
        presenter.gameTypeSelected(.Practice, view: UIView())
        self.viewController.dismissViewControllerAnimated(true, completion: nil)
        
        presenter.difficultySelected(.Veteran)
        XCTAssert(presenter.difficulty == .Veteran)
    }
    
    func test_AllProSelected() {
        presenter.gameTypeSelected(.Practice, view: UIView())
        self.viewController.dismissViewControllerAnimated(true, completion: nil)
        
        presenter.difficultySelected(.AllPro)
        XCTAssert(presenter.difficulty == .AllPro)
    }
    
}
