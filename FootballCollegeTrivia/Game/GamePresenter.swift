//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit

class GamePresenter: NSObject, GameTimerProtocol {
    unowned let view: GameView
    let difficulty: Difficulty
    let gameType: GameType
    
    var gameButtons:[UIButton] = []
    var canGuess:Bool = true
    var players:[Player] = []
    var player: Player!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var score:Int = 0
    var strikes:Int = 0
    
    required init(view: GameView, difficulty: Difficulty, gameType: GameType) {
        self.view = view
        self.difficulty = difficulty
        self.gameType = gameType
        super.init()
        GameTimer.presenter = self
    }
    
    // MARK: - Setup
    
    func setup(gameButtons:[UIButton]) {
        self.gameButtons = gameButtons
        setupQuestions()
        setupGamePlaySettings()
        setupGameModeSpecificSettings()
        finishGamePreperation()
        generateQuestion()
    }
    
    func setupQuestions() {
        self.players = Player.getCurrentArray(self.difficulty)
        self.players.shuffle()
    }
    
    func setupGamePlaySettings() {
        canGuess = true
        score = 0
        strikes = 0
    }
    
    func setupGameModeSpecificSettings() {
        switch gameType {
            case .Standard:
                self.view.applyModeDisplay("2:00", color: .darkGrayColor())
                startTimer()
            case .Survival:
                self.view.applyModeDisplay(" ", color: .redColor())
            case .Practice:
                self.view.applyModeDisplay("Practice", color: .lightGrayColor())
            }
    }
    
    func finishGamePreperation() {
        self.view.showBestScore(getBestScoreForDifficulty(difficulty, gametype: gameType))
        self.view.displayStartText()
    }
    
    // MARK: - Questions
    
    func generateQuestion() {
        canGuess = true
        if self.players.count == 0 {
            setupQuestions() // Questions are empty.. reset them
            generateQuestion()
        } else {
            player = players[0]
            self.players.removeAtIndex(0)
            self.view.displayPlayer(player)
            generateAnswers()
        }
    }
    
    // MARK: - Answers
    
    func generateAnswers() {
        var choices = [String]()
        choices.append(player.college)
        var colleges = College.getCurrentArray(player.tier)
        
        repeat
        {
            let index = Int(arc4random_uniform((UInt32(colleges.count))))
            let c = colleges[index]
            if choices.filter({ el in el == c.name }).count == 0 {
                choices.append(c.name)
            }
            
        }while( choices.count < 4 );
        sortChoices(choices)
    }
    
    func sortChoices(choices: [String]) {
        let sortedChoices = choices.sort()
        displayChoices(sortedChoices)
    }
    
    func displayChoices(choices: [String]) {
        var index = 0
        for college in choices {
            let button = gameButtons[index]
            button.setTitle(college, forState: .Normal)
            
            if appDelegate.testMode {
                if college == player.college {
                    button.accessibilityIdentifier = "answer"
                } else {
                    button.accessibilityIdentifier = ""
                }
            }
            index++
        }
    }
    
    // MARK: - Guesses
    
    func checkGuess(button: UIButton) {
        if !canGuess {
            return
        }
        canGuess = false
        
        if button.titleForState(.Normal) == player.college {
            guessWasCorrect(button)
        } else {
            guessWasIncorrect(button)
        }
    }
    
    func guessWasCorrect(sender: UIButton) {
        self.view.displayCorrectGuessText()
        self.correctGuess()
        
        sender.correct { () -> Void in
            self.generateQuestion()
        }
    }
    
    func guessWasIncorrect(sender: UIButton) {
        // Display what was correct answer
        for button in gameButtons {
            if button.titleForState(.Normal) == player.college {
                button.correct()
                self.view.displayWrongGuessText(player.college)
            }
        }
        
        self.wrongGuess()
        sender.incorrect { () -> Void in
            self.generateQuestion()
        }
    }
    
    func correctGuess() {
        score++
        self.view.updateScore(score)
    }
    
    func wrongGuess() {
        if gameType == .Survival {
            strikes++
            self.view.updateStrikes(stringForSurvivalMode(strikes))
            if strikes >= 3 {
                self.view.finishGame()
            }
        } else if gameType == .Standard {
            score--
            self.view.updateScore(score)
        }
    }
    
    func saveHighScore() {
        if score > getBestScoreForDifficulty(difficulty, gametype: gameType) {
            saveBestScoreForDifficulty(difficulty, gametype: gameType, score: score)
        }
    }
    
    // MARK: - Timer 
    
    func startTimer() {
        GameTimer.start()
    }

    func stopTimer() {
        GameTimer.stop()
    }
    
    // MARK: - GameTimerProtocol
    
    func timeFinished() {
        self.view.finishGame()
    }
    
    func timeTicked(displayText: String, color: UIColor) {
        self.view.applyModeDisplay(displayText, color: color)
    }
}
