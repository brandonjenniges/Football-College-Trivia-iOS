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
    
    static let storyboardId = String(GameViewController)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gameOver" {
            let viewController:ResultsViewController = segue.destinationViewController as! ResultsViewController
            viewController.score = self.presenter.score
            self.presenter.saveHighScore()
        }
    }
    
    // MARK: - Starting setup display
    
    func applyModeDisplay(text: String, color: UIColor) {
        self.modeLabel.text = text
        self.modeLabel.textColor = color
    }
    
    func displayStartText() {
        resultLabel.text = "GO!"
        resultLabel.textColor = .lightGrayColor()
    }
    
    func showBestScore(score: Int) {
        bestLabel.text = "\(score)"
    }
    
    // MARK: - Game
    
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
    
    func updateScore(score: Int) {
        currentLabel.text = "\(score)"
    }
    
    func updateStrikes(strikes: String) {
        modeLabel.text = strikes
    }
    
    // MARK: - Finish
    
    func finishGame() {
        self.performSegueWithIdentifier("gameOver", sender: self)
    }
    
    //MARK: Button Press
    
    @IBAction func guessButtonPressed(sender: UIButton) {
        self.presenter.checkGuess(sender)        
    }
    
    @IBAction func returnHome(segue: UIStoryboardSegue) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
}