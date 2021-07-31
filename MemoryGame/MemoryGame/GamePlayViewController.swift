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
    
    var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureNavigationBar()
        configureCollectionView()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        title = gridSizeString
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
