//
//  Copyright © 2014-2015 Brandon Jenniges. All rights reserved.
//

import UIKit

class TitleViewController: GAITrackedViewController {
    
    var currentDifficulty: Difficulty?
    var currentGameType: GameType?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.screenName = "Title"
        Player.getAllPlayers()
    }

    // MARK: Difficulty
    func showDifficultyPicker(sourceView: UIView) {
        let controller = UIAlertController(title: "Choose a difficulty", message: "", preferredStyle: .ActionSheet)
        controller.addAction(UIAlertAction(title: "Rookie", style: .Default, handler: { (UIAlertAction) -> Void in
            self.currentDifficulty = .Rookie
            self.performSegueWithIdentifier("playGame", sender: self)
        }))
        controller.addAction(UIAlertAction(title: "Starter", style: .Default, handler: { (UIAlertAction) -> Void in
            self.currentDifficulty = .Starter
            self.performSegueWithIdentifier("playGame", sender: self)
        }))
        controller.addAction(UIAlertAction(title: "Veteran", style: .Default, handler: { (UIAlertAction) -> Void in
            self.currentDifficulty = .Veteran
            self.performSegueWithIdentifier("playGame", sender: self)
        }))
        controller.addAction(UIAlertAction(title: "All-Pro", style: .Default, handler: { (UIAlertAction) -> Void in
            self.currentDifficulty = .AllPro
            self.performSegueWithIdentifier("playGame", sender: self)
        }))
        controller.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        controller.popoverPresentationController?.sourceRect = sourceView.bounds
        controller.popoverPresentationController?.sourceView = sourceView
        self.navigationController?.presentViewController(controller, animated: true, completion: nil)
    }
    
    //MARK: Buttons
    @IBAction func standardButtonPressed(sender: UIView) {
        self.showDifficultyPicker(sender)
        self.currentGameType = .Standard
    }
    
    @IBAction func survivalButtonPressed(sender: UIView) {
        self.showDifficultyPicker(sender)
        self.currentGameType = .Survival
    }
    
    @IBAction func practiceButtonPressed(sender: UIView) {
        self.showDifficultyPicker(sender)
        self.currentGameType = .Practice
    }
    
    //MARK: Rate
    @IBAction func ratePressed(sender: AnyObject) {
        rateApp()
    }
    
    //MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playGame" {
            if let viewController: GameViewController = segue.destinationViewController as? GameViewController {
                
                //Safety checks
                if self.currentDifficulty == nil {
                    self.currentDifficulty = .Rookie
                }
                if self.currentGameType == nil {
                    self.currentGameType = .Standard
                }
                
                viewController.currentGameType = self.currentGameType
                viewController.currentDifficulty = self.currentDifficulty
            }
        }
    }
}

