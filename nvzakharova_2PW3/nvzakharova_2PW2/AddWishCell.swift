//
//  AddWishCell.swift
//  nvzakharova_2PW2
//
//  Created by Наталья Захарова on 10.11.2023.
//

import UIKit

final class AddWishCell: UITableViewCell, UITextFieldDelegate {
    
    static let addWishReuseId: String = "addWishReuseId"
        let textField: UITextField = UITextField()
        private let addWishButton: UIButton = UIButton()
        
        var tableView: UITableView?
        
        // MARK: - Lifecycle
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            configureUI()
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("Error")
        }
        
        private func configureUI() {
            configureText()
        }
        
        private func configureText() {
            selectionStyle = .none
            backgroundColor = .black
            
            let wrap: UIView = UIView()
            
            contentView.addSubview(wrap)
            
            wrap.translatesAutoresizingMaskIntoConstraints = false
            wrap.backgroundColor = .white
            wrap.layer.cornerRadius = 15
            
            wrap.pinVertical(to: self, 5)
            wrap.pinHorizontal(to: self, 10)
            
            wrap.addSubview(textField)
            
    //        wishTextField.translatesAutoresizingMaskIntoConstraints = false
            textField.delegate = self
            textField.backgroundColor = .none
            textField.placeholder = "Write your wish here"
            
            
            contentView.addSubview(addWishButton)
            
            addWishButton.translatesAutoresizingMaskIntoConstraints = false
            addWishButton.setTitle("Add new wish", for: .normal)
            addWishButton.setTitleColor(.yellow, for: .normal)
            addWishButton.setTitleColor(.black, for: .highlighted)
            addWishButton.layer.cornerRadius = 15
            addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
            
            addWishButton.pinTop(to: wrap.bottomAnchor, 10)
        }
        
        @objc func addWishButtonPressed(){
            
        }
}
