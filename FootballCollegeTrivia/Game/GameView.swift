//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit

protocol GameView: class {
    func applyMode(text: String, color: UIColor)
    
    func displayPlayer(player: Player)
    
    func correctGuess()
    func wrongGuess()
    
    func finishGame()
    
}