//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit

class TitlePresenter {
    unowned let view: TitleView
    var difficulty: Difficulty = .Rookie
    var gameType: GameType = .Practice
    
    required init(view: TitleView) {
        self.view = view
    }
    
    func gameTypeSelected(gameType: GameType, view: UIView) {
        self.gameType = gameType
        self.view.showDifficultyPicker(view)
    }
    
    func difficultySelected(difficulty: Difficulty) {
        self.difficulty = difficulty
        self.view.playGame()
    }
}