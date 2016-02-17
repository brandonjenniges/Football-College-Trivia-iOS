//
//  Copyright © 2014-2016 Brandon Jenniges. All rights reserved.
//

import UIKit

func rateApp() {
    let string = "itms-apps://itunes.apple.com/app/id879870156"
    UIApplication.sharedApplication().openURL(NSURL(string: string)!)
}