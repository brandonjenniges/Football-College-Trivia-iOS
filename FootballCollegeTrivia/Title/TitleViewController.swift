//
//  Copyright © 2014-2016 Brandon Jenniges. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController, TitleView {
    
    static let storyboardId = String(TitleViewController)
    var presenter: TitlePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TitlePresenter(view: self)
        Player.getAllPlayers()
    }
    
    // MARK: - Difficulty
    
    func showDifficultyPicker(sourceView: UIView) {
        let controller = UIAlertController(title: "Choose a difficulty", message: "", preferredStyle: .ActionSheet)
        controller.addAction(UIAlertAction(title: "Rookie", style: .Default, handler: { (UIAlertAction) -> Void in
            self.presenter.difficultySelected(.Rookie)
        }))
        controller.addAction(UIAlertAction(title: "Starter", style: .Default, handler: { (UIAlertAction) -> Void in
            self.presenter.difficultySelected(.Starter)
        }))
        controller.addAction(UIAlertAction(title: "Veteran", style: .Default, handler: { (UIAlertAction) -> Void in
            self.presenter.difficultySelected(.Veteran)
        }))
        controller.addAction(UIAlertAction(title: "All-Pro", style: .Default, handler: { (UIAlertAction) -> Void in
            self.presenter.difficultySelected(.AllPro)
        }))
        controller.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        controller.popoverPresentationController?.sourceRect = sourceView.bounds
        controller.popoverPresentationController?.sourceView = sourceView
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    // MARK: - Buttons
    
    @IBAction func standardButtonPressed(view: UIView) {
        self.presenter.gameTypeSelected(.Standard, view: view)
    }
    
    @IBAction func survivalButtonPressed(view: UIView) {
        self.presenter.gameTypeSelected(.Survival, view: view)
    }
    
    @IBAction func practiceButtonPressed(view: UIView) {
        self.presenter.gameTypeSelected(.Practice, view: view)
    }
    
    // MARK: - Rate
    
    @IBAction func ratePressed(sender: AnyObject) {
        rateApp()
    }
    
    // MARK: - Segue
    
    func playGame() {
        self.performSegueWithIdentifier("playGame", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playGame" {
            if let viewController: GameViewController = segue.destinationViewController as? GameViewController {
                viewController.currentGameType = self.presenter.gameType
                viewController.currentDifficulty = self.presenter.difficulty
            }
        }
    }
}

