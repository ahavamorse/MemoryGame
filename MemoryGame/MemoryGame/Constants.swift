//
//  Constants.swift
//  MemoryGame
//
//  Created by HapiDani on 7/31/21.
//  Copyright © 2021 ahavamorse. All rights reserved.
//

import UIKit

enum CardImages {
    static let cardBack = UIImage(named: "allCardBacks")
    
    static let bat = UIImage(named: "memoryBatCardFront")!
    static let cat = UIImage(named: "memoryCatCardFront")!
    static let cow = UIImage(named: "memoryCowCardFront")!
    static let dragon = UIImage(named: "memoryDragonFront")!
    static let man = UIImage(named: "memoryGarbageManCardFront")!
    static let dog = UIImage(named: "memoryGhostDogCardFront")!
    static let hen = UIImage(named: "memoryHenCardFront")!
    static let horse = UIImage(named: "memoryHorseCardFront")!
    static let pig = UIImage(named: "memoryPigCardFront")!
    static let spider = UIImage(named: "memorySpiderCardFront")!
}

enum Colors {
    static let gamePlayBackground = UIColor(named: "gamePlayBackgroundColor")
    static let lobbyBackground = UIColor(named: "lobbyBackgroundColor")
    static let lobbyButtonsBackground = UIColor(named: "lobbyButtonsBackgroundColor")
}

enum GridSizeStrings {
    static let twoByFive = "2 Cards x 5 Cards"
    static let threeByFour = "3 Cards x 4 Cards"
    static let fourByFour = "4 Cards x 4 Cards"
    static let fourByFive = "4 Cards x 5 Cards"
}
