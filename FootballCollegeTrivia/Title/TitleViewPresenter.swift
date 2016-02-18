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
        showDifficultyPicker(view)
    }
    
    func difficultySelected(difficulty: Difficulty) {
        self.difficulty = difficulty
        self.view.playGame()
    }
    
    func showDifficultyPicker(sourceView: UIView) {
        let controller = UIAlertController(title: "Choose a difficulty", message: "", preferredStyle: .ActionSheet)
        controller.addAction(UIAlertAction(title: "Rookie", style: .Default, handler: { (UIAlertAction) -> Void in
            self.difficultySelected(.Rookie)
        }))
        controller.addAction(UIAlertAction(title: "Starter", style: .Default, handler: { (UIAlertAction) -> Void in
            self.difficultySelected(.Starter)
        }))
        controller.addAction(UIAlertAction(title: "Veteran", style: .Default, handler: { (UIAlertAction) -> Void in
            self.difficultySelected(.Veteran)
        }))
        controller.addAction(UIAlertAction(title: "All-Pro", style: .Default, handler: { (UIAlertAction) -> Void in
            self.difficultySelected(.AllPro)
        }))
        controller.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        controller.popoverPresentationController?.sourceRect = sourceView.bounds
        controller.popoverPresentationController?.sourceView = sourceView
        self.view.presentDifficultyPicker(controller)
    }
}