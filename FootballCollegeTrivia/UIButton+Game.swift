//
//  Copyright © 2014-2015 Brandon Jenniges. All rights reserved.
//

import UIKit

var positiveColor = UIColor(red: 0/255.0, green: 200/255.0, blue: 0/255.0, alpha: 1.0)
var negativeColor = UIColor(red: 200/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
var positiveAnimationDuration = 1.0
var negativeAnimationDuration = 1.0

public extension UIButton {
    
    public func correct() {
        correct(nil)
    }
    
    public func correct( completionClosure:(()->())?) {
        
        let originalColor = self.titleColorForState(.Normal)
        self.setTitleColor(positiveColor, forState: .Normal)
        
        let animationDuration = positiveAnimationDuration
        let scale:CGFloat = 1.2
        
        let animation = CABasicAnimation(keyPath: "transform")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.duration = animationDuration
        animation.repeatCount = 1
        animation.removedOnCompletion = true
        animation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(scale, scale, 1.0))
        self.layer.addAnimation(animation, forKey: nil)
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(animationDuration * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            if let completionClosure = completionClosure {
                completionClosure()
            }
            self.setTitleColor(originalColor, forState: .Normal)
        }
    }
    
    func incorrect() {
        incorrect(nil)
    }
    
    func incorrect( completionClosure:(()->())?) {
        
        let originalColor = self.titleColorForState(.Normal)
        self.setTitleColor(negativeColor, forState: .Normal)
        
        let animationDuration = negativeAnimationDuration
        let offsetX:CGFloat = 10.0
        
        let animation = CAKeyframeAnimation(keyPath: "transform")
        
        let shiftLeftTransform = NSValue(CATransform3D: CATransform3DMakeTranslation(-offsetX, 0, 0))
        let shiftRightTransform = NSValue(CATransform3D: CATransform3DMakeTranslation(offsetX, 0, 0))
        
        animation.values = [shiftLeftTransform, shiftRightTransform]
        animation.autoreverses = true
        animation.repeatCount = 2.0
        animation.duration = animationDuration / 4.0
        self.layer.addAnimation(animation, forKey: nil)
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(animationDuration * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            if let completionClosure = completionClosure {
                completionClosure()
            }
            self.setTitleColor(originalColor, forState: .Normal)
        }
    }
}
