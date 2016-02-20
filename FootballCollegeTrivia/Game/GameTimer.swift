//
//  Copyright © 2016 Brandon Jenniges. All rights reserved.
//

import UIKit

protocol GameTimerProtocol {
    func timeTicked(displayText: String, color: UIColor)
    func timeFinished()
}

class GameTimer: NSObject {
    static var timer = NSTimer()
    static var minutes = 0
    static var seconds = 0
    static var secondsLeft = 0
    
    static var presenter: GamePresenter!
    
    static func start() {
        secondsLeft = 120;
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateCounter", userInfo: nil, repeats: true)
    }
    
    static func stop() {
        timer.invalidate()
    }
    
    static func updateCounter() {
        if GameTimer.secondsLeft > 0 {
            GameTimer.secondsLeft--
            GameTimer.minutes = (GameTimer.secondsLeft % 3600) / 60
            GameTimer.seconds = (GameTimer.secondsLeft % 3600) % 60
            let displayText = String(format: "%d", GameTimer.minutes) + ":" + String(format: "%02d", GameTimer.seconds)
            var color: UIColor = .darkGrayColor()
            if GameTimer.secondsLeft <= 10 {
                color = .redColor()
            }
            presenter.timeTicked(displayText, color: color)
        } else {
            stop()
            presenter.timeFinished()
        }
    }
}