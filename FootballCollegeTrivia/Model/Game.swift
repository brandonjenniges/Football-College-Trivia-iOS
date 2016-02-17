//
//  Copyright © 2014-2015 Brandon Jenniges. All rights reserved.
//

import Foundation

enum GameType : Int {
    case Standard = 1, Survival = 2, Practice = 3
}

enum Difficulty : Int {
    case Rookie = 1, Starter = 2, Veteran = 3, AllPro = 4
}

func stringForDifficulty(difficulty: Difficulty) -> String {
    switch difficulty {
    case .Rookie:
        return "Rookie"
    case .Starter:
        return "Starter"
    case .Veteran:
        return "Veteran"
    case .AllPro:
        return "All-Pro"
    }
}

func getBestScoreForDifficulty(difficulty: Difficulty, gametype: GameType) -> Int  {
    return NSUserDefaults.standardUserDefaults().integerForKey("GameVairation\(difficulty)-\(gametype))")
}

func saveBestScoreForDifficulty(difficulty: Difficulty, gametype: GameType, score: Int)  {
    NSUserDefaults.standardUserDefaults().setInteger(score, forKey: "GameVairation\(difficulty)-\(gametype))")
    NSUserDefaults.standardUserDefaults().synchronize()
}

func stringForSurvivalMode(strikes: Int) -> String {
    switch strikes {
    case 1:
        return "X"
    case 2:
        return "X X"
    case 3:
        return "X X X"
    default:
        return ""
    }
}