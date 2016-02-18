//
//  Copyright © 2014-2016 Brandon Jenniges. All rights reserved.
//

import Foundation
import UIKit

class GameViewController: UIViewController, GameView {
    
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
    
    //MARK: Game Elements
    var score:Int = 0
    var correctAnswer:String?
    
    //Survival
    var strikes:Int = 0
    
    //Standard
    
    var presenter: GamePresenter!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        title = stringForDifficulty(presenter.difficulty)
        self.presenter.gameButtons = [firstButton, secondButton, thirdButton, fourthButton]
        self.presenter.setup()
        self.presenter.setupGameModeSpecificSettings()
        
        score = 0
        getBestScore()
        
        strikes = 0
        
        resultLabel.text = "GO!"
        resultLabel.textColor = .lightGrayColor()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.presenter.stopTimer()
    }
    
    func applyMode(text: String, color: UIColor) {
        self.modeLabel.text = text
        self.modeLabel.textColor = color
    }
    
    func finishGame() {
        self.performSegueWithIdentifier("gameOver", sender: self)
    }
    
    func displayPlayer(player: Player) {
        proTeamLabel.text = player.proTeam
        playerLabel.text = player.getDisplayText()
    }
    
    //MARK: Button Press
    @IBAction func guessButtonPressed(sender: UIButton) {
        // Make sure user can't spam guesses
        if !self.presenter.canGuess {
            return
        }
        self.presenter.canGuess = false
        
        if sender.titleForState(.Normal) == self.presenter.player.college {
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
            self.presenter.generateQuestion()
        }
    }
    
    func guessWasIncorrect(sender: UIButton) {
        // Display what was correct answer
        for button in self.presenter.gameButtons {
            if button.titleForState(.Normal) == self.presenter.player.college {
                button.correct()
                self.resultLabel.text = self.presenter.player.college
                self.resultLabel.textColor = .redColor()
            }
        }
        
        self.wrongGuess()
        sender.incorrect { () -> Void in
            self.presenter.generateQuestion()
        }
    }
    
    func correctGuess() {
        score++
        setCurrentScore()
    }
    
    func wrongGuess() {
        if presenter.gameType == .Survival {
            strikes++
            modeLabel.text = stringForSurvivalMode(strikes)
            if strikes >= 3 {
                performSegueWithIdentifier("gameOver", sender: self)
            }
        } else if presenter.gameType == .Standard {
            score--
            setCurrentScore()
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
        bestLabel.text = "\(getBestScoreForDifficulty(presenter.difficulty, gametype: presenter.gameType))"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gameOver" {
            let viewController:ResultsViewController = segue.destinationViewController as! ResultsViewController
            viewController.score = score
            
            if score > getBestScoreForDifficulty(presenter.difficulty, gametype: presenter.gameType) {
                saveBestScoreForDifficulty(presenter.difficulty, gametype: presenter.gameType, score: score)
            }
        }
    }
}