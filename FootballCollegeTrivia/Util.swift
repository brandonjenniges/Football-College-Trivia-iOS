//
//  Copyright © 2014-2015 Brandon Jenniges. All rights reserved.
//

import Foundation

func rateApp() {
    let string = "itms-apps://itunes.apple.com/app/id879870156"
    UIApplication.sharedApplication().openURL(NSURL(string: string)!)
}