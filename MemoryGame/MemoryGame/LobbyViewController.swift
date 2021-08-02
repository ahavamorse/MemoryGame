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
    var buttons: [UIButton] = []
    let buttonTitles: [String] = [GridSizeStrings.twoByFive, GridSizeStrings.threeByFour, GridSizeStrings.fourByFour, GridSizeStrings.fourByFive]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureNavigationBar()
        configureBackButton()
        configureTitleLabel()
        configureStackView()
        configureButtons()
        configureUI()
    }
    
    private func configureViewController() {
        view.backgroundColor = Colors.lobbyBackground
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configureBackButton() {
        let backButtonImage = UIImage(named: "backNavButton")
        navigationController?.navigationBar.backIndicatorImage = backButtonImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    }
    
    private func configureTitleLabel() {
        titleLabel.text = "Memory Game"
        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        titleLabel.textColor = .label
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
        for index in 0...buttonTitles.count {
            let button = UIButton(frame: .zero)
            buttons.append(button)
            
            button.backgroundColor = Colors.lobbyButtonsBackground
            button.layer.cornerRadius = 15
            button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
            button.setTitleColor(.systemBackground, for: .normal)
            
            button.tag = index
            button.setTitle(buttonTitles[index], for: .normal)
            button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        }
    }
    
    private func configureUI() {
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 75),
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
    
    @objc private func startGame(sender: UIButton) {
        let gamePlayViewController = GamePlayViewController()
        let gamePlayController = GamePlayController()
        gamePlayController.setGridSize(buttonIndex: sender.tag)
        
        gamePlayViewController.gamePlayController = gamePlayController
        gamePlayViewController.gridSizeString = buttonTitles[sender.tag]
        navigationController?.pushViewController(gamePlayViewController, animated: true)
    }
}
