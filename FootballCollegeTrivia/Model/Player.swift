//
//  Copyright © 2014-2016 Brandon Jenniges. All rights reserved.
//

import SwiftyJSON

class Player: CustomStringConvertible, Equatable {
    let firstName: String
    let lastName: String
    let proTeam: String
    let position: String
    let jerseyNumber: Int
    let overall: Int
    let college: String
    let tier: Int
    
    struct PlayerArrays {
        static var allPlayers = [Player]?()
        static var rookiePlayers = [Player]?()
        static var starterPlayers = [Player]?()
        static var veteranPlayers = [Player]?()
    }
    
    init(json: JSON) {
        firstName = json["firstName"].stringValue
        lastName = json["lastName"].stringValue
        proTeam = json["proTeam"].stringValue
        position = json["position"].stringValue
        jerseyNumber = json["jerseyNumber"].intValue
        overall = json["overall"].intValue
        college = json["college"].stringValue
        tier = json["tier"].intValue
    }
    
    static func getAllPlayers() -> [Player] {
        if let allPlayers = PlayerArrays.allPlayers {
            return allPlayers
        }
        PlayerArrays.allPlayers = loadPlayersArray()
        return PlayerArrays.allPlayers!
    }
    
    static func getRookiePlayers() -> [Player] {
        if let rookiePlayers = PlayerArrays.rookiePlayers {
            return rookiePlayers
        }
        
        PlayerArrays.rookiePlayers = getAllPlayers().filter {
            if $0.overall >= 80 && ($0.position == "QB" || $0.position == "RB" || $0.position == "WR") {
                return true
            }
            return false
        }
        
        return PlayerArrays.rookiePlayers!
    }
    
    static func getStarterPlayers() -> [Player] {
        if let starterPlayers = PlayerArrays.starterPlayers {
            return starterPlayers
        }
        
        PlayerArrays.starterPlayers = getAllPlayers().filter {
            if $0.position == "QB" || $0.position == "RB" || $0.position == "WR" {
                return true
            }
            return false
        }
        
        return PlayerArrays.starterPlayers!
    }
    
    static func getVeteranPlayers() -> [Player] {
        if let veteranPlayers = PlayerArrays.veteranPlayers {
            return veteranPlayers
        }
        
        PlayerArrays.veteranPlayers = getAllPlayers().filter {
            if $0.overall >= 76 {
                return true
            }
            return false
        }
        
        return PlayerArrays.veteranPlayers!
    }
    
    static func loadPlayersArray() -> [Player] {
        let contents: NSString?
        do {
            contents = try NSString(contentsOfFile: NSBundle.mainBundle().pathForResource("all_players", ofType: "txt")!, encoding: NSUTF8StringEncoding)
            
            if let data = contents?.dataUsingEncoding(NSUTF8StringEncoding) {
                let json = JSON(data: data)
                let players = json["players"]
                var playersArray = [Player]()
                for (index: _, subJson: JSON) in players {
                    if JSON["college"] != "NULL" {
                        playersArray.append(Player(json: JSON))
                    }
                }
                return playersArray
            }
        } catch _ {
            print("error trying load players")
        }
        return [Player]()
    }
    
    static func getCurrentArray(currentDifficulty: Difficulty) -> [Player] {
        switch currentDifficulty {
        case .Rookie:
            return getRookiePlayers()
        case .Starter:
            return getStarterPlayers()
        case .Veteran:
            return getVeteranPlayers()
        case .AllPro:
            return getAllPlayers()
        }
    }
    
    func getDisplayText() -> String {
        return "\(firstName) \(lastName) \(position) #\(jerseyNumber)"
    }
    
    // MARK: - Debug printing
    
    var description: String {
        return "Name: \(firstName) \(lastName) pos: \(position) #\(jerseyNumber) team: \(proTeam) college: \(college) tier: \(tier)"
    }
}

// MARK: Equatable
func ==(lhs: Player, rhs: Player) -> Bool {
    return lhs.getDisplayText() == rhs.getDisplayText() && lhs.overall == rhs.overall && lhs.college == rhs.college
}
