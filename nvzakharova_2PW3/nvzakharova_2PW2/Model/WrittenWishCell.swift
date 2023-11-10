//
//  WrittenWishCell.swift
//  nvzakharova_2PW2
//
//  Created by Наталья Захарова on 10.11.2023.
//

import UIKit
final class WrittenWishCell: UITableViewCell {
    static let reuseId: String = "Written Wish Cell"
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
    }
    private let wishLabel: UILabel = UILabel()
    
    public var wishText : String {
            return wishLabel.text ?? String()
        }
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        func configure(with wish: String) {
            wishLabel.text = wish
        }
        private func configureUI() {
            selectionStyle = .none
            backgroundColor = .clear
            let wrap: UIView = UIView()
            addSubview(wrap)
            wrap.backgroundColor = Constants.wrapColor
            wrap.layer.cornerRadius = Constants.wrapRadius
            wrap.pinVertical(to: self, Constants.wrapOffsetV)
            wrap.pinHorizontal(to: self, Constants.wrapOffsetH)
            wrap.addSubview(wishLabel)
            wishLabel.pin(to: wrap, Constants.wishLabelOffset)
        }
}



