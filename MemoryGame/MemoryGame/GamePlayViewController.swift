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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureNavigationBar()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = gridSizeString
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = false
    }
}
