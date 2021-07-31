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
    let buttons = [UIButton(frame: .zero), UIButton(frame: .zero), UIButton(frame: .zero), UIButton(frame: .zero)]
    let sizeStrings = ["2 Cards x 5 Cards", "3 Cards x 4 Cards", "4 Cards x 4 Cards", "4 Cards x 5 Cards"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureStackView()
        configureButtons()
        configureUI()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Memory Game"
    }
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        for button in buttons {
            stackView.addArrangedSubview(button)
        }
    }
    
    private func configureButtons() {
        for index in 0...3 {
            let button = buttons[index]
            button.backgroundColor = .secondaryLabel
            button.layer.cornerRadius = 15
            button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
            
            button.tag = index
            button.setTitle(sizeStrings[index], for: .normal)
            button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        }
    }
    
    @objc private func startGame(sender: UIButton) {
        
    }
    
    private func configureUI() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
            
//            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        for button in buttons {
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalTo: stackView.widthAnchor)
            ])
        }
    }
}
