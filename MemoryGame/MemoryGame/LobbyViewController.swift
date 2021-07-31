//
//  LobbyViewController.swift
//  MemoryGame
//
//  Created by HapiDani on 7/31/21.
//  Copyright © 2021 ahavamorse. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {
    
    let buttonStackView = UIStackView()
    let buttonsArray = Array(repeating: UIButton(), count: 4)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Memory Game"
    }
}
