//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit

class GamePresenter {
    unowned let view: GameView
    let difficulty: Difficulty
    let gameType: GameType
    
    required init(view: GameView, difficulty: Difficulty, gameType: GameType) {
        self.view = view
        self.difficulty = difficulty
        self.gameType = gameType
    }
}