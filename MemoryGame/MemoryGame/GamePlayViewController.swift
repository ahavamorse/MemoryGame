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
    
    var cards: [Card] = []
    var numOfCardPairs: Int {
        let totalNumOfCards = gridWidth * gridHeight
        return totalNumOfCards / 2
    }
    
    var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureNavigationBar()
        
        createCards()
        configureCollectionView()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        title = gridSizeString
    }
    
    private func createCards() {
        let cardImages: [UIImage] = getCardImages()
        for image in cardImages {
            cards.append(Card(image: image))
            cards.append(Card(image: image))
        }
        cards = cards.shuffled()
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
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let flowLayout = createCollectionViewFlowLayout(columns: CGFloat(gridWidth))
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CardCell") // to do: create custom cell type
    }
    
    private func createCollectionViewFlowLayout(columns: CGFloat) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        
        let edgeInset: CGFloat = 15
        let itemSpacing: CGFloat = 10
        
        let totalSpacing: CGFloat = (edgeInset * 2) + (itemSpacing * (columns - 1))
        
        let totalCellsWidth = width - totalSpacing
        let cellWidth = totalCellsWidth / columns
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: edgeInset, left: edgeInset, bottom: edgeInset, right: edgeInset)
        flowLayout.itemSize = CGSize(width: cellWidth, height: 2 * cellWidth)
        
        return flowLayout
    }
}

extension GamePlayViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}
