//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit

class GamePresenter: NSObject {
    unowned let view: GameView
    let difficulty: Difficulty
    let gameType: GameType
    
    var gameButtons:[UIButton]!
    var canGuess:Bool = true
    var players:[Player]!
    var player: Player!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    required init(view: GameView, difficulty: Difficulty, gameType: GameType) {
        self.view = view
        self.difficulty = difficulty
        self.gameType = gameType
    }
    
    func setup() {
        canGuess = true
        self.players = Player.getCurrentArray(self.difficulty)
        self.players.shuffle()
        generateQuestion()
    }
    
    func setupGameModeSpecificSettings() {
        switch gameType {
            case .Standard:
                self.view.applyMode("2:00", color: .darkGrayColor())
                startTimer()
            case .Survival:
                self.view.applyMode(" ", color: .redColor())
            case .Practice:
                self.view.applyMode("Practice", color: .lightGrayColor())
            }
    }
    
    // MARK: - Questions
    
    func generateQuestion() {
        canGuess = true
        if self.players.count == 0 {
            self.players = Player.getCurrentArray(self.difficulty)
            self.players.shuffle()
        } else {
            player = players[0]
            self.players.removeAtIndex(0)
            self.view.displayPlayer(player)
            generateAnswers()
        }
    }
    
    func generateAnswers() {
        //correctAnswer = currentPlayer.college
        
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
    
    // MARK: - Timer 
    
    func startTimer() {
        GameTimer.secondsLeft = 120;
        GameTimer.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateCounter", userInfo: nil, repeats: true)
    }
    
    func updateCounter() {
        if GameTimer.secondsLeft > 0 {
            GameTimer.secondsLeft--
            GameTimer.minutes = (GameTimer.secondsLeft % 3600) / 60
            GameTimer.seconds = (GameTimer.secondsLeft % 3600) % 60
            let displayText = String(format: "%d", GameTimer.minutes) + ":" + String(format: "%02d", GameTimer.seconds)
            var color: UIColor = .darkGrayColor()
            if GameTimer.secondsLeft <= 10 {
                color = .redColor()
            }
            self.view.applyMode(displayText, color: color)
        } else {
            stopTimer()
            self.view.finishGame()
        }
    }

    
    func stopTimer() {
        GameTimer.timer.invalidate()
    }
}
