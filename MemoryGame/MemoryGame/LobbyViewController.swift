//
//  LobbyViewController.swift
//  MemoryGame
//
//  Created by HapiDani on 7/31/21.
//  Copyright © 2021 ahavamorse. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {
    
    let titleLabel = UILabel()
    let stackView = UIStackView()
    let buttons = [UIButton(frame: .zero), UIButton(frame: .zero), UIButton(frame: .zero), UIButton(frame: .zero)]
    let sizeStrings = ["2 Cards x 5 Cards", "3 Cards x 4 Cards", "4 Cards x 4 Cards", "4 Cards x 5 Cards"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTitleLabel()
        configureStackView()
        configureButtons()
        configureUI()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemTeal
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureTitleLabel() {
        titleLabel.text = "Memory Game"
        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        titleLabel.textColor = .systemBackground
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
            button.backgroundColor = .tertiaryLabel
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
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        
        for button in buttons {
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalTo: stackView.widthAnchor)
            ])
        }
    }
}
