//
//  Copyright © 2015-2016 Brandon Jenniges. All rights reserved.
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
        let _ = viewController.view // force view creation
    }
    
    override func tearDown() {
        super.tearDown()
        presenter.stopTimer()
    }
    
    func test_init() {
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(presenter)
    }
    
    func test_setupButtons() {
        XCTAssert(presenter.gameButtons.count == 0)
        presenter.setup([UIButton(), UIButton(), UIButton(), UIButton()])
        XCTAssert(presenter.gameButtons.count == 4)
    }
    
    func test_setupQuestions() {
        let unsortedPlayerArray = Player.getCurrentArray(presenter.difficulty)
        XCTAssert(presenter.players.count == 0)
        presenter.setupQuestions()
        XCTAssert(presenter.players.count > 0)
        XCTAssert(presenter.players.count == unsortedPlayerArray.count)
        XCTAssert(presenter.players != unsortedPlayerArray)
    }
    
    func test_setupGamePlaySettings() {
        presenter.setupGamePlaySettings()
        XCTAssert(presenter.canGuess == true)
        XCTAssert(presenter.score == 0)
        XCTAssert(presenter.strikes == 0)
    }
    
    func test_setupGameModeSpecificSettingsForStandard() {
        //Resetup presenter
        presenter = GamePresenter(view: viewController, difficulty: .Rookie, gameType: .Standard)
        viewController.presenter = presenter
        
        presenter.setupGameModeSpecificSettings()
        XCTAssert(viewController.modeLabel.text == "2:00")
        XCTAssert(viewController.modeLabel.textColor == UIColor.darkGrayColor())
    }
    
    func test_setupGameModeSpecificSettingsForSurvival() {
        //Resetup presenter
        presenter = GamePresenter(view: viewController, difficulty: .Rookie, gameType: .Survival)
        viewController.presenter = presenter
        
        presenter.setupGameModeSpecificSettings()
        XCTAssert(viewController.modeLabel.text == " ")
        XCTAssert(viewController.modeLabel.textColor == UIColor.redColor())
    }
    
    func test_setupGameModeSpecificSettingsForPractice() {
        //Resetup presenter
        presenter = GamePresenter(view: viewController, difficulty: .Rookie, gameType: .Practice)
        viewController.presenter = presenter
        
        presenter.setupGameModeSpecificSettings()
        XCTAssert(viewController.modeLabel.text == "Practice")
        XCTAssert(viewController.modeLabel.textColor == UIColor.lightGrayColor())
    }
    
    func test_generateQuestionWhenPlayersArrayIsEmpty() {
        // Prepare with game buttons
        presenter.setup([UIButton(), UIButton(), UIButton(), UIButton()])
        
        presenter.players.removeAll()
        XCTAssert(presenter.players.count == 0)
        presenter.generateQuestion()
        XCTAssert(presenter.players.count > 0)
    }
    
    // MARK: - Guess testings
    
    func test_checkGuessWhenGuessIsCorrect() {
        // Prepare with game buttons and questions
        presenter.setup([UIButton(), UIButton(), UIButton(), UIButton()])
        presenter.generateQuestion()
        
        let correctButton = UIButton()
        correctButton.setTitle(presenter.player.college, forState: .Normal)
        presenter.checkGuess(correctButton)
        
        XCTAssert(presenter.canGuess == false)
        XCTAssert(correctButton.titleColorForState(.Normal) == positiveColor)
    }
    
    func test_checkGuessWhenGuessIsWrong() {
        // Prepare with game buttons and questions
        presenter.setup([UIButton(), UIButton(), UIButton(), UIButton()])
        presenter.generateQuestion()
        
        let wrongButton = UIButton()
        wrongButton.setTitle("Donald Trump University", forState: .Normal)
        presenter.checkGuess(wrongButton)
        
        XCTAssert(presenter.canGuess == false)
        XCTAssert(wrongButton.titleColorForState(.Normal) == negativeColor)
    }
    
    func test_guessMadeWhenGuessNotAllowed() {
        // Prepare with game buttons and questions
        presenter.setup([UIButton(), UIButton(), UIButton(), UIButton()])
        presenter.generateQuestion()
        
        // Fake guess was made
        presenter.canGuess = false
        
        let button = UIButton()
        let originalTitleColor = button.titleColorForState(.Normal)
        button.setTitle("Donald Trump University", forState: .Normal)
        presenter.checkGuess(button)
        
        XCTAssert(presenter.canGuess == false)
        XCTAssert(button.titleColorForState(.Normal) == originalTitleColor)
        XCTAssert(button.titleColorForState(.Normal) != positiveColor)
        XCTAssert(button.titleColorForState(.Normal) != positiveColor)
    }
    
    func test_wrongGuessWhenSurvivalMode() {
        //Resetup presenter
        presenter = GamePresenter(view: viewController, difficulty: .Rookie, gameType: .Survival)
        viewController.presenter = presenter
        
        // Prepare with game buttons and questions
        presenter.setup([UIButton(), UIButton(), UIButton(), UIButton()])
        presenter.generateQuestion()
        
        let wrongButton = UIButton()
        wrongButton.setTitle("Donald Trump University", forState: .Normal)
        
        let strikesBeforeGuess = presenter.strikes
        presenter.checkGuess(wrongButton)
        
        XCTAssert(presenter.strikes == strikesBeforeGuess + 1)
    }
    
    func test_scoringWhenCorrectGuessIsMadeInStandardMode() {
        //Resetup presenter
        presenter = GamePresenter(view: viewController, difficulty: .Rookie, gameType: .Standard)
        viewController.presenter = presenter
        
        // Prepare with game buttons and questions
        presenter.setup([UIButton(), UIButton(), UIButton(), UIButton()])
        presenter.generateQuestion()
        
        let correctButton = UIButton()
        correctButton.setTitle(presenter.player.college, forState: .Normal)
        
        let scoreBeforeGuess = presenter.score
        presenter.checkGuess(correctButton)
        
        XCTAssert(presenter.score == scoreBeforeGuess + 1)
        
    }
    
    func test_scoringWhenWrongGuessIsMadeInStandardMode() {
        //Resetup presenter
        presenter = GamePresenter(view: viewController, difficulty: .Rookie, gameType: .Standard)
        viewController.presenter = presenter
        
        // Prepare with game buttons and questions
        presenter.setup([UIButton(), UIButton(), UIButton(), UIButton()])
        presenter.generateQuestion()
        
        let wrongButton = UIButton()
        wrongButton.setTitle("Donald Trump University", forState: .Normal)
        
        let scoreBeforeGuess = presenter.score
        presenter.checkGuess(wrongButton)
        
        XCTAssert(presenter.score == scoreBeforeGuess - 1)
        
    }
    
    // MARK: - GameTimer
    
    func test_startGameTimer() {
        presenter.startTimer()
        XCTAssert(GameTimer.secondsLeft == 120)
        XCTAssert(GameTimer.timer.valid == true)
    }
    
    func test_stopGameTimer() {
        presenter.stopTimer()
        XCTAssert(GameTimer.timer.valid == false)
    }
    
    func test_restartGameTimer() {
        presenter.startTimer()
        presenter.stopTimer()
        presenter.startTimer()
        XCTAssert(GameTimer.secondsLeft == 120)
        XCTAssert(GameTimer.timer.valid == true)
    }
    
    // MARK: - GameTimerProtocol
    
    func test_gameTimerFinished() {
        GameTimer.secondsLeft == 0
        GameTimer.updateCounter()
        sleep(1)
    }
    
    func test_timeTicked() {
        presenter.timeTicked("1:15", color: .redColor())
        XCTAssert(viewController.modeLabel.text == "1:15")
        XCTAssert(viewController.modeLabel.textColor == UIColor.redColor())
        
    }
}
