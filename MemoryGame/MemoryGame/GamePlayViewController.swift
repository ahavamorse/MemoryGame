//
//  GamePlayViewController.swift
//  MemoryGame
//
//  Created by HapiDani on 7/31/21.
//  Copyright © 2021 ahavamorse. All rights reserved.
//

import UIKit

class GamePlayViewController: UIViewController {
    
    var gridSizeString: String = ""
    var flippedCell: CardCollectionViewCell?
    
    var gamePlayController: GamePlayController!
    var collectionView: UICollectionView!
    let attemptLabel = UIBarButtonItem(title: "Attempts: 0", style: .plain, target: nil, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureAttemptLabel()
        configureNavigationBar()
        gamePlayController.createCards()
        configureCollectionView()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = gridSizeString
    }
    
    private func configureAttemptLabel() {
        navigationItem.rightBarButtonItem = attemptLabel
        attemptLabel.isEnabled = false
        attemptLabel.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.label], for: .disabled)
    }
    
    private func configureCollectionView() {
        let flowLayout = createCollectionViewFlowLayout(columns: CGFloat(gamePlayController.gridWidth))
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = Colors.gamePlayBackground
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
    
    private func updateAttemptLabel() {
        attemptLabel.title = "Attempts: \(gamePlayController.matchAttmpts)"
    }
}

extension GamePlayViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gamePlayController.cardImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reuseID, for: indexPath) as! CardCollectionViewCell
        cell.set(frontImage: gamePlayController.cardImages[indexPath.row])
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
                        // Cards match
                        self.gamePlayController.matchedPairs += 1
                        self.gamePlayController.checkForWin() { alert in
                            if let alert = alert {
                                self.present(alert, animated: true)
                            }
                        }
                    }
                    // All unmatched cards have been flipped back
                    self.flippedCell = nil
                } else {
                    // This is the first flipped card
                    self.flippedCell = selectedCell
                    self.gamePlayController.matchAttmpts += 1
                    self.updateAttemptLabel()
                }
            }
        }
    }
}
