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
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.7)
        ])
    }
    
    func set(frontImage: UIImage) {
        cardBackImageView.image = CardImages.cardBack
        cardFrontImageView.image = frontImage
    }
    
    func flipToFront(completion: @escaping () -> Void) {
        configure(cardFrontImageView)
        UIView.transition(from: cardBackImageView, to: cardFrontImageView, duration: 0.25, options: [.transitionFlipFromBottom]) { _ in
            completion()
        }
    }
    
    func flipToBack() {
        configure(cardBackImageView)
        UIView.transition(from: cardFrontImageView, to: cardBackImageView, duration: 0.25, options: [.transitionFlipFromBottom])
    }
}
