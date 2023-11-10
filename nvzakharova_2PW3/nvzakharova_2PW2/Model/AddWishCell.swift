import UIKit
final class AddWishCell: UITableViewCell {
    static let reuseId: String = "AddWishCell"
    private let removeButton: UIButton = UIButton(type: .system)
    private let wishText: UITextView = UITextView()
    private let addWishButton: UIButton = UIButton(type: .system)
    private var addWish: ((String) -> ())?
    public var wishContent : String {
        get {
            wishText.text
        }
        set (newText) {
            wishText.text = newText
        }
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
    
    func configure(action: @escaping (String) -> ()) {
        addWish = action;
    }
    
    private func configureUI() {
       
        selectionStyle = .none
        backgroundColor = .clear
        
        let wrap: UIView = UIView()
        contentView.addSubview(wrap)
        
        
        
        wrap.isUserInteractionEnabled = true
        wrap.backgroundColor = .clear
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.pin(to: contentView);
        wrap.addSubview(wishText)
        wrap.addSubview(addWishButton)
        wrap.setHeight(Constants.wrapHeight)
        
        wishText.pinHorizontal(to: wrap, Constants.wrapOffsetH)
        wishText.pinTop(to: wrap, Constants.wishTextTop)
        wishText.setHeight(Constants.wishTextHeight)
        wishText.layer.cornerRadius = Constants.wishTextRadius
        addWishButton.setTitle(Constants.addWishButtonTitle, for: .normal)
        addWishButton.setTitleColor(.white, for: .normal)
        addWishButton.backgroundColor = .systemPink
        addWishButton.layer.cornerRadius = Constants.addWishButtonRadius
        addWishButton.pinTop(to: wishText.bottomAnchor, Constants.addWishButtonTop)
        addWishButton.pinRight(to: wishText)
        addWishButton.setWidth(Constants.addWishButtonWidth)
        addWishButton.setHeight(Constants.addWishButtonHeight)
        addWishButton.addTarget(self, action: #selector(addWishButtonTapped), for: .touchUpInside)
        addWishButton.centerXAnchor.constraint(equalTo: wishText.centerXAnchor).isActive = true
        
        
    }
    
    @objc func addWishButtonTapped() {
        addWish?(wishText.text)
        wishText.text = String()
    }
}
