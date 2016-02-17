//
//  Copyright © 2014-2016 Brandon Jenniges. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    static let storyboardId = String(ResultsViewController)
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var score:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
    }
    
    // MARK: - Return Home
    
    @IBAction func returnHome(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    // MARK: - Play Again
    
    @IBAction func playAgain(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Rate
    
    @IBAction func ratePressed(sender: AnyObject) {
        rateApp()
    }
}