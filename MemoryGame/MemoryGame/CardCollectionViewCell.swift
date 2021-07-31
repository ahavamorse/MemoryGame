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
    
    var isFlipped: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure(cardBackImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(_ imageView: UIImageView) {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func set(frontImage: UIImage) {
        cardBackImageView.image = CardImages.cardBack
        cardFrontImageView.image = frontImage
    }
    
    func flipToFront() {
        if isFlipped == false {
            configure(cardFrontImageView)
            UIView.transition(from: cardBackImageView, to: cardFrontImageView, duration: 0.25, options: [.transitionFlipFromBottom])
            isFlipped = true
        }
    }
    
    func flipToBack() {
        configure(cardBackImageView)
        UIView.transition(from: cardFrontImageView, to: cardBackImageView, duration: 0.25, options: [.transitionFlipFromBottom])
        isFlipped = false
    }
}
