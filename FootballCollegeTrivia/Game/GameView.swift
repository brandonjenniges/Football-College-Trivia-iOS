//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit

protocol GameView: class {
    
    // MARK: - Starting setup display
    
    func applyModeDisplay(text: String, color: UIColor)
    func displayStartText()
    func showBestScore(score: Int)
    
    // MARK: - Game
    
    func displayPlayer(player: Player)
    func displayCorrectGuessText()
    func displayWrongGuessText(answer: String)
    func updateScore(score: Int)
    func updateStrikes(strikes: String)
    
    // MARK: - Finish
    
    func finishGame()
    
}