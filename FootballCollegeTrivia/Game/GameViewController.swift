//
//  Copyright © 2014-2016 Brandon Jenniges. All rights reserved.
//

import Foundation
import UIKit

class GameViewController: UIViewController {
    
    var currentDifficulty: Difficulty!
    var currentGameType: GameType!
    
    var gameName:String!
    
    //MARK: Outlets
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var proTeamLabel: UILabel!
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var bestLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    
    var gameButtons:[UIButton]!
    
    //MARK: Game Elements
    var currentArray:[Player]?
    var currentPlayer: Player!
    
    var score:Int = 0
    var canGuess:Bool = true
    var correctAnswer:String?
    
    //Survival
    var strikes:Int = 0
    
    //Standard
    static var timer = NSTimer()
    static var minutes = 0
    static var seconds = 0
    static var secondsLeft = 0
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        gameButtons = [firstButton, secondButton, thirdButton, fourthButton]
        setupGameModeSpecificSettings()
        getCurrentArray()
        
        score = 0
        setCurrentScore()
        getBestScore()
        
        strikes = 0
        canGuess = true
        
        resultLabel.text = "GO!"
        resultLabel.textColor = UIColor.lightGrayColor()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        GameViewController.timer.invalidate()
    }
    
    func generateQuestion() {
        canGuess = true
        if let currentArray = currentArray {
            if currentArray.count == 0 {
                getCurrentArray()
            } else {
                currentPlayer = currentArray[0]
                proTeamLabel.text = currentPlayer.proTeam
                self.currentArray?.removeAtIndex(0)
                playerLabel.text = currentPlayer.getDisplayText()
                generateAnswers()
            }
        }
    }
    
    func generateAnswers() {
        correctAnswer = currentPlayer.college
        
        var choices = [String]()
        choices.append(correctAnswer!)
        
        var colleges = College.getCurrentArray(currentPlayer.tier)
        
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
                if college == correctAnswer {
                    button.accessibilityIdentifier = "answer"
                } else {
                    button.accessibilityIdentifier = ""
                }
            }
            index++
        }
    }
    
    func getCurrentArray() {
        if let currentDifficulty = currentDifficulty {
            currentArray = Player.getCurrentArray(currentDifficulty)
            currentArray?.shuffle()
            self.title = stringForDifficulty(currentDifficulty)
        }
        generateQuestion()
    }
    
    //MARK: Button Press
    @IBAction func guessButtonPressed(sender: UIButton) {
        // Make sure user can't spam guesses
        if !canGuess {
            return
        }
        canGuess = false
        
        if sender.titleForState(.Normal) == currentPlayer.college {
            guessWasCorrect(sender)
        } else {
            guessWasIncorrect(sender)
        }
    }
    
    func guessWasCorrect(sender: UIButton) {
        self.resultLabel.text = "Correct!"
        self.resultLabel.textColor = positiveColor
        
        self.correctGuess()
        
        sender.correct { () -> Void in
            self.generateQuestion()
        }
    }
    
    func guessWasIncorrect(sender: UIButton) {
        // Display what was correct answer
        for button in gameButtons {
            if button.titleForState(.Normal) == currentPlayer.college {
                button.correct()
                self.resultLabel.text = currentPlayer.college
                self.resultLabel.textColor = UIColor.redColor()
            }
        }
        
        self.wrongGuess()
        sender.incorrect { () -> Void in
            self.generateQuestion()
        }
    }
    
    func correctGuess() {
        score++
        setCurrentScore()
    }
    
    func wrongGuess() {
        if currentGameType == .Survival {
            strikes++
            modeLabel.text = stringForSurvivalMode(strikes)
            if strikes >= 3 {
                performSegueWithIdentifier("gameOver", sender: self)
            }
        } else if currentGameType == .Standard {
            score--
            setCurrentScore()
        }
    }
    
    func setupGameModeSpecificSettings() {
        switch self.currentGameType! {
        case .Standard:
            gameName = "Standard"
            modeLabel.text = "2:00"
            startCountDownTimer()
            break
        case .Survival:
            gameName = "Survival"
            modeLabel.text = " "
            modeLabel.textColor = UIColor.redColor()
            break
        case .Practice:
            gameName = "Practice"
            modeLabel.text = "Practice"
            modeLabel.textColor = UIColor.lightGrayColor()
            break
        }
    }
    
    @IBAction func returnHome(segue: UIStoryboardSegue) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    //MARK: Scores
    func setCurrentScore() {
        currentLabel.text = "\(score)"
    }
    
    //MARK: High Scores
    func getBestScore() {
        bestLabel.text = "\(getBestScoreForDifficulty(currentDifficulty))"
    }
    
    //MARK: Standard
    func startCountDownTimer() {
        GameViewController.secondsLeft = 120;
        GameViewController.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateCounter", userInfo: nil, repeats: true)
    }
    
    func updateCounter() {
        if GameViewController.secondsLeft > 0 {
            GameViewController.secondsLeft--
            GameViewController.minutes = (GameViewController.secondsLeft % 3600) / 60
            GameViewController.seconds = (GameViewController.secondsLeft % 3600) % 60
            modeLabel.text = String(format: "%d", GameViewController.minutes) + ":" + String(format: "%02d", GameViewController.seconds)
            modeLabel.textColor = UIColor.darkGrayColor()
            if GameViewController.secondsLeft <= 10 {
                modeLabel.textColor = UIColor.redColor()
            }
        } else {
            GameViewController.timer.invalidate()
            self.performSegueWithIdentifier("gameOver", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gameOver" {
            let viewController:ResultsViewController = segue.destinationViewController as! ResultsViewController
            viewController.score = score
            
            if score > getBestScoreForDifficulty(currentDifficulty) {
                saveBestScoreForDifficulty(currentDifficulty, score: score)
            }
        }
    }
}