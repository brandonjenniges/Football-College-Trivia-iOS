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
    var correctAnswer:String?
    
    var presenter: GamePresenter!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        title = stringForDifficulty(presenter.difficulty)
        self.presenter.setup([firstButton, secondButton, thirdButton, fourthButton])
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
    
    func displayStartText() {
        resultLabel.text = "GO!"
        resultLabel.textColor = .lightGrayColor()
    }
    
    func displayPlayer(player: Player) {
        proTeamLabel.text = player.proTeam
        playerLabel.text = player.getDisplayText()
    }
    
    func displayCorrectGuessText() {
        self.resultLabel.text = "Correct!"
        self.resultLabel.textColor = positiveColor
    }
    
    func displayWrongGuessText(answer: String) {
        self.resultLabel.text = answer
        self.resultLabel.textColor = .redColor()
    }
    
    //MARK: Button Press
    @IBAction func guessButtonPressed(sender: UIButton) {
        self.presenter.checkGuess(sender)        
    }
    
    @IBAction func returnHome(segue: UIStoryboardSegue) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    //MARK: Scores
    func updateScore(score: Int) {
        currentLabel.text = "\(score)"
    }
    
    //MARK: High Scores
    func showBestScore(score: Int) {
        bestLabel.text = "\(score)"
    }
    
    func updateStrikes(strikes: String) {
        modeLabel.text = strikes
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gameOver" {
            let viewController:ResultsViewController = segue.destinationViewController as! ResultsViewController
            viewController.score = self.presenter.score
            self.presenter.saveHighScore()
        }
    }
}