//
//  Copyright © 2014-2016 Brandon Jenniges. All rights reserved.
//

import SwiftyJSON

class College: Equatable {
    let name: String
    let tier: Int
    
    struct CollegeArrays {
        static var allColleges:[College]?
        static var tierOneColleges:[College]?
        static var tierTwoColleges:[College]?
        static var tierThreeColleges:[College]?
    }
    
    init(json: JSON) {
        self.name = json["college"].stringValue
        self.tier = json["tier"].intValue
    }
    
    // MARK: - JSON loading
    
    static func loadCollegesArray() -> [College] {
        let contents: NSString?
        do {
            contents = try NSString(contentsOfFile: NSBundle.mainBundle().pathForResource("all_colleges", ofType: "txt")!, encoding: NSUTF8StringEncoding)
            
            if let data = contents?.dataUsingEncoding(NSUTF8StringEncoding) {
                let json = JSON(data: data)
                let colleges = json["colleges"]
                var collegesArray = [College]()
                for (index: _, subJson: JSON) in colleges {
                    collegesArray.append(College(json: JSON))
                }
                return collegesArray
            }
        } catch _ {
            print("error trying load colleges")
        }
        return [College]()
    }
    
    // MARK: - Getters
    
    static func getAllColleges() -> [College] {
        if let allColleges = CollegeArrays.allColleges {
            return allColleges
        }
        
        CollegeArrays.allColleges = loadCollegesArray()
        return CollegeArrays.allColleges!
    }
    
    static func getTierOneColleges() -> [College] {
        if let tierOneColleges = CollegeArrays.tierOneColleges {
            return tierOneColleges
        }
        
        let colleges = getCollegesForTier(1)
        CollegeArrays.tierOneColleges = colleges
        
        return CollegeArrays.tierOneColleges!
    }
    
    static func getTierTwoColleges() -> [College] {
        if let tierTwoColleges = CollegeArrays.tierTwoColleges {
            return tierTwoColleges
        }
        
        let colleges = getCollegesForTier(2)
        CollegeArrays.tierTwoColleges = colleges
        
        return CollegeArrays.tierTwoColleges!
    }
    
    static func getTierThreeColleges() -> [College] {
        if let tierThreeColleges = CollegeArrays.tierThreeColleges {
            return tierThreeColleges
        }
        
        let colleges = getCollegesForTier(3)
        CollegeArrays.tierThreeColleges = colleges
        
        return CollegeArrays.tierThreeColleges!
    }
    
    // MARK: - Helper methods
    
    static func getCollegesForTier(tier : Int) -> [College] {
        let colleges = getAllColleges().filter { (college: College) -> Bool in
            return college.tier == tier
        }
        return colleges
    }
    
    static func getCurrentArray(tier: Int) -> [College] {
        switch tier {
        case 1:
            return getTierOneColleges()
        case 2:
            return getTierTwoColleges()
        case 3:
            return getTierThreeColleges()
        default:
            return getTierOneColleges()
        }
    }
}

// MARK: Equatable
func ==(lhs: College, rhs: College) -> Bool {
    return lhs.name == rhs.name && lhs.tier == rhs.tier
}

