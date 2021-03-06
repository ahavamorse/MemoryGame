//
//  GamePlayController.swift
//  MemoryGame
//
//  Created by HapiDani on 8/1/21.
//  Copyright © 2021 ahavamorse. All rights reserved.
//

import UIKit

class GamePlayController {
    
    var gridWidth: Int = 0
    var gridHeight: Int = 0
    var matchedPairs: Int = 0
    var matchAttmpts: Int = 0
    var cardImages: [UIImage] = []
    
    var numOfCardPairs: Int {
        let totalNumOfCards = gridWidth * gridHeight
        return totalNumOfCards / 2
    }
    
    func setGridSize(buttonIndex: Int) {
        switch buttonIndex {
        case 0:
            // Grid Size is 2x5
            gridWidth = 2
            gridHeight = 5
        case 1:
            // Grid Size is 3x4
            gridWidth = 3
            gridHeight = 4
        case 2:
            // Grid Size is 4x4
            gridWidth = 4
            gridHeight = 4
        default:
            // Grid Size is 4x5
            gridWidth = 4
            gridHeight = 5
        }
    }
    
    func createCards() {
        let images: [UIImage] = getRandomCardImages()
        let imagePairs = images + images
        cardImages = imagePairs.shuffled()
    }
    
    func getRandomCardImages() -> [UIImage] {
        var allImages = [CardImages.bat, CardImages.cat, CardImages.cow, CardImages.dog, CardImages.dragon, CardImages.hen, CardImages.horse, CardImages.man, CardImages.pig, CardImages.spider]
        
        var randomImages: [UIImage] = []
        
        if numOfCardPairs == 10 {
            return allImages
        } else {
            allImages.shuffle()
            for _ in 1...numOfCardPairs {
                randomImages.append(allImages.popLast()!)
            }
            return randomImages
        }
    }
    
    func checkForWin(completed: @escaping (UIAlertController?) -> Void) {
        if matchedPairs == numOfCardPairs {
            let alert = UIAlertController(title: "You've Done It!", message: "Congratulations! You matched all the cards and won the game! It took you \(matchAttmpts) attempts.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Hooray!", style: .default, handler: nil))
            completed(alert)
        }
    }
}
