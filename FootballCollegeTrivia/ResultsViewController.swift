//
//  Copyright © 2014-2015 Brandon Jenniges. All rights reserved.
//

import Foundation

class ResultsViewController: GAITrackedViewController {
    
    //MARK: Outlets
    @IBOutlet weak var scoreLabel: UILabel!
    var score:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.screenName = "Results"
        scoreLabel.text = "Score: \(score)"
    }
    
    //MARK: Return Home
    @IBAction func returnHome(sender: AnyObject) {
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    //MARK: Play Again
    @IBAction func playAgain(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: Rate
    @IBAction func ratePressed(sender: AnyObject) {
        rateApp()
    }
}