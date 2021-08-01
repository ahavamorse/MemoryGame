//
//  GamePlayViewController.swift
//  MemoryGame
//
//  Created by HapiDani on 7/31/21.
//  Copyright © 2021 ahavamorse. All rights reserved.
//

import UIKit

class GamePlayViewController: UIViewController {
    
    var gridWidth: Int = 0
    var gridHeight: Int = 0
    var gridSizeString: String = ""
    
    var cardImages: [UIImage] = []
    var flippedCell: CardCollectionViewCell?
    var numOfCardPairs: Int {
        let totalNumOfCards = gridWidth * gridHeight
        return totalNumOfCards / 2
    }
    
    var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        createCards()
        configureCollectionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureNavigationBar()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = gridSizeString
    }
    
    private func createCards() {
        let images: [UIImage] = getCardImages()
        let imagePairs = images + images
        cardImages = imagePairs.shuffled()
    }
    
    private func getCardImages() -> [UIImage] {
        switch numOfCardPairs {
        case 5:
            return [CardImages.bat, CardImages.cat, CardImages.cow, CardImages.dog, CardImages.dragon]
        case 6:
            return [CardImages.bat, CardImages.cat, CardImages.cow, CardImages.dog, CardImages.dragon, CardImages.hen]
        case 8:
            return [CardImages.bat, CardImages.cat, CardImages.cow, CardImages.dog, CardImages.dragon, CardImages.hen, CardImages.horse, CardImages.man]
        default:
            return [CardImages.bat, CardImages.cat, CardImages.cow, CardImages.dog, CardImages.dragon, CardImages.hen, CardImages.horse, CardImages.man, CardImages.pig, CardImages.spider]
        }
    }
    
    private func configureCollectionView() {
        let flowLayout = createCollectionViewFlowLayout(columns: CGFloat(gridWidth))
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.reuseID)
    }
    
    private func createCollectionViewFlowLayout(columns: CGFloat) -> UICollectionViewFlowLayout {
        if columns == 2 {
            // Limited by vertical space
            let itemSpacing: CGFloat = 10
            
            let verticalInset: CGFloat = 15
            let totalVerticalSpacing = (verticalInset * 2) + (itemSpacing * 4)
            let totalCellsHeight = 700 - totalVerticalSpacing
            let cellHeight = totalCellsHeight / 5
            
            let horizontalInset: CGFloat = 50
            let totalHorizontalSpacing = (horizontalInset * 2) + itemSpacing
            let totalCellsWidth = view.bounds.width - totalHorizontalSpacing
            let cellWidth = totalCellsWidth / 2
            
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.sectionInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
            flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
            
            return flowLayout
        }
        // Limited by horizontal space
        let edgeInset: CGFloat = 15
        let itemSpacing: CGFloat = 10
        let totalSpacing: CGFloat = (edgeInset * 2) + (itemSpacing * (columns - 1))

        let totalCellsWidth = view.bounds.width - totalSpacing
        let cellWidth = totalCellsWidth / columns
        var cellHeight: CGFloat!
        if columns == 3 {
            cellHeight = 165
        } else {
            cellHeight = 127
        }

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: edgeInset, left: edgeInset, bottom: edgeInset, right: edgeInset)
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        return flowLayout
    }
}

extension GamePlayViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reuseID, for: indexPath) as! CardCollectionViewCell
        cell.set(frontImage: cardImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        if selectedCell != flippedCell {
            // Card is not yet flipped
            selectedCell.flipToFront() { [weak self] in
                guard let self = self else { return }
                
                if let firstCell = self.flippedCell {
                    // A card has already been flipped
                    let firstImage = firstCell.cardFrontImageView.image
                    let secondImage = selectedCell.cardFrontImageView.image
                    
                    if firstImage != secondImage {
                        // Cards don't match
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            firstCell.flipToBack()
                            selectedCell.flipToBack()
                        }
                    } else {
                        // to do: count matched cards and tries to alert user of wins and losses
                    }
                    // All unmatched cards have been flipped back
                    self.flippedCell = nil
                } else {
                    // This is the first flipped card
                    self.flippedCell = selectedCell
                }
            }
        }
    }
}
