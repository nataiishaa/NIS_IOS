//
//  WishMakerViewController.swift
//  nvzakharova_2PW2
//
//  Created by Наталья Захарова on 06.10.2023.
//

import UIKit

final class WishMakerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    enum Constants {
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let red: String = "Red"
        static let blue: String = "Blue"
        static let green: String = "Green"
        
        
        static let leading: CGFloat = 20
        
        static let stackRadius: CGFloat = 20
        static let stackBottom: CGFloat = -20
        
        static let titleText: String = "WishMaker"
        static let titleTop: CGFloat = 30
       
        static let descriptionText: String = "You can change the screen color using buttons. Smile more often and use a palette"
        static let descriptionTop: CGFloat = 40
        static let descriptionTrailing: CGFloat = -40
        
        static let buttonActive: String = "Hide"
        static let buttonDisabled: String = "Show"
        static let buttonRandomColor: String = "Random color"
    }
    
    private var backgroundRed: CGFloat = 0
    private var backgroundGreen: CGFloat = 0
    private var backgroundBlue: CGFloat = 0
    
    private let stack: UIStackView = UIStackView()
    private let button: CustomButton = CustomButton(activeText: Constants.buttonActive, disabledText: Constants.buttonDisabled)
    private let bludeSlider = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
    private let greenSlider = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
    private let redSlider = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
    
    private func configureUI() {
        view.backgroundColor = .black
        
        configureTitle()
        configureDescription()
        configureButton()
        configureStack()
    }
    
    private func configureStack() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.backgroundColor = .white
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackRadius
        stack.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leading),
            stack.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: Constants.stackBottom)
        ])
        
        configureSliders()
        
    }
    private func configureTitle() {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = Constants.titleText
        title.font = UIFont.boldSystemFont(ofSize: 32)
        title.textColor = .darkGray
        
        view.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leading),
            title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.leading)
        ])
    }
    
    private func configureDescription() {
        let title = view.subviews.first
        
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.text = Constants.descriptionText
        description.lineBreakMode = NSLineBreakMode.byWordWrapping
        description.numberOfLines = 0
        description.font = UIFont.boldSystemFont(ofSize: 25)
        description.textColor = .green
        
        view.addSubview(description)
        
        NSLayoutConstraint.activate([
            description.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            description.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leading),
            description.topAnchor.constraint(equalTo: title!.bottomAnchor, constant: Constants.descriptionTop),
            description.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.descriptionTrailing)
        ])
    }
    
  
    
    private func configureButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leading),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        button.buttonPressed = { value in
            UIView.animate(withDuration: 0.5, animations: {
                if(value) {
                    self.stack.alpha = 1
                } else {
                    self.stack.alpha = 0
                }
                self.view.layoutIfNeeded()
            }, completion: { (val: Bool) in
                self.stack.isHidden = !val
            })
        }
    }
    
    private func configureSliders() {
        
        for slider in [redSlider, bludeSlider, greenSlider] {
            stack.addArrangedSubview(slider)
        }
        
        redSlider.valueChanged = { [weak self] value in
            self?.backgroundRed = value
            self?.changeBackground()
        }
        greenSlider.valueChanged = { [weak self] value in
            self?.backgroundGreen = value
            self?.changeBackground()
        }
        bludeSlider.valueChanged = { [weak self] value in
            self?.backgroundBlue = value
            self?.changeBackground()
        }
    }
   
    
    private func changeBackground() {
        view.backgroundColor = UIColor(red: backgroundRed, green: backgroundGreen, blue: backgroundBlue, alpha: 2)
    }
    
    private func changeSliders() {
        redSlider.slider.value = Float(backgroundRed)
        greenSlider.slider.value = Float(backgroundGreen)
        bludeSlider.slider.value = Float(backgroundBlue)
    }
}
