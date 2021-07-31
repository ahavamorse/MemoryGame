//
//  CardCollectionViewCell.swift
//  MemoryGame
//
//  Created by HapiDani on 7/31/21.
//  Copyright © 2021 ahavamorse. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "CardCollectionViewCell"
    let cardFrontImageView = UIImageView(frame: .zero)
    let cardBackImageView = UIImageView(frame: .zero)
    
    let image: UIImage
    let isFlipped: Bool = false
}
