//
//  CustomButton.swift
//  nvzakharova_2PW2
//
//  Created by Наталья Захарова on 06.10.2023.
//

import UIKit

final class CustomButton : UIButton {
    var buttonPressed: ((Bool) -> Void)?
    var isActive: Bool = true
    private var active: String?
    private var disabled: String?
    
    init(activeText: String, disabledText: String) {
        super.init(frame: .zero)
        
        active = activeText
        disabled = disabledText
        
        self.setTitle(active, for: .normal)
        self.addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
    init(title: String) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.addTarget(self, action: #selector(pressedSimple), for: .touchUpInside)
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func pressed() {
        isActive = !isActive
        if(isActive) {
            self.setTitle(active, for: .normal)
        } else {
            self.setTitle(disabled, for: .normal)
        }
        buttonPressed?(isActive)
    }
    
    @objc
    func pressedSimple() {
        isActive = !isActive
        buttonPressed?(isActive)
    }
    
    
}
