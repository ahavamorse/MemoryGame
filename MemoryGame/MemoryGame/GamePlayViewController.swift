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
        let edgeInset: CGFloat = 15
        let itemSpacing: CGFloat = 10
        let totalSpacing: CGFloat = (edgeInset * 2) + (itemSpacing * (columns - 1))

        let totalCellsWidth = view.bounds.width - totalSpacing
        let cellWidth = totalCellsWidth / columns
        let cellHeight = cellWidth * 1.435374

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
}
