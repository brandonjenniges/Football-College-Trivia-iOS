//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit

protocol GameView: class {
    func applyMode(text: String, color: UIColor)
    
    func displayStartText()
    func showBestScore(score: Int)
    
    func displayPlayer(player: Player)
    
    func displayCorrectGuessText()
    func displayWrongGuessText(answer: String)
    
    func updateScore(score: Int)
    
    func updateStrikes(strikes: String)
    
    func finishGame()
}