//
//  ViewController.swift
//  seminar2
//
//  Created by Наталья Захарова on 22.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    private func configureUI() {
        let ourView = UIView()
        
        view.addSubview(ourView)
        ourView.backgroundColor = .blue
        
        ourView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ourView.heightAnchor.constraint(equalToConstant: 250),
            ourView.widthAnchor.constraint(equalToConstant: 250),
            ourView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ourView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)
        ])
        
        let otherView = UIView()
        view.addSubview(otherView)
        
        otherView.pinLeft(to: ourView.leadingAnchor)
        otherView.backgroundColor = .darkGray
        otherView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        otherView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        otherView.centerYAnchor.constraint(equalTo: ourView.centerYAnchor).isActive = true
    }
}
