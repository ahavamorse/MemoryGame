//
//  LobbyViewController.swift
//  MemoryGame
//
//  Created by HapiDani on 7/31/21.
//  Copyright © 2021 ahavamorse. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {
    
    let stackView = UIStackView()
    let buttons = Array(repeating: UIButton(), count: 4)
    let sizeStrings = ["2 x 5", "3 x 4", "4 x 4", "4 x 5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureStackView()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Memory Game"
    }
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        for button in buttons {
            stackView.addArrangedSubview(button)
        }
    }
}
