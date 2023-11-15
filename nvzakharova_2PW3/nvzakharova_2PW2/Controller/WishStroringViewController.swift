import UIKit

final class WishStoringViewController: UIViewController {
    
    
    private let defaults = UserDefaults.standard
    private var table: UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = ["I wish to add cells to the table"]
    private let removeButton: UIButton = UIButton(type: .system)
    override func viewDidLoad() {
        view.backgroundColor = .systemTeal
        configureTable()
        configureRemoveButton()
        wishArray = defaults.array(forKey: Constants.key) as? [String] ?? [];
    }
    
   
    
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .systemTeal
        table.dataSource = self
        table.register(WrittenWishCell.self, forCellReuseIdentifier: Constants.writtenReuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: Constants.addReuseId)
        table.pin(to: view, Constants.wishTableOffset)
    }
}


extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == Constants.zero {
            return Constants.numberSells;
        }
        return wishArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == Constants.zero {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.addReuseId, for: indexPath)
            guard let addWishCell = cell as? AddWishCell else { return cell }
            addWishCell.configure(action: {[weak self] wish in
                if wish.isEmpty {
                    return;
                }
                self?.wishArray.append(wish)
                self?.table.reloadData()
                self?.defaults.set(self?.wishArray, forKey: Constants.key)
            })
            
            return addWishCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.writtenReuseId, for: indexPath)
        guard let wishCell = cell as? WrittenWishCell else { return cell }
        wishCell.configure(with: wishArray[indexPath.row])
        
        return wishCell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            if section == Constants.addWishSectionIndex {
                return Constants.addWishSectionHeaderTitle;
            }
            return Constants.wishSectionHeaderTitle
        }
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberSection
    }
    func configureRemoveButton(){
            view.addSubview(removeButton)
        removeButton.setTitle(Constants.clearMes, for: .normal)
            removeButton.setTitleColor(.red, for: .normal)
            removeButton.backgroundColor = .systemYellow
            removeButton.layer.cornerRadius = Constants.buttonRadius
            removeButton.widthAnchor.constraint(equalToConstant: 260).isActive = true
        removeButton.bottomAnchor.constraint(equalTo: self.table.topAnchor, constant: 600).isActive = true
            removeButton.setHeight(Constants.buttonHeight)
            removeButton.centerXAnchor.constraint(equalTo: self.table.centerXAnchor).isActive = true
            removeButton.addTarget(self, action: #selector(clearAllButtonTapped), for: .touchUpInside)
        }
        
        @objc
        func clearAllButtonTapped() {
            while (!wishArray.isEmpty){
                wishArray.popLast()
            }
            self.table.reloadData()
            self.defaults.set(self.wishArray, forKey: Constants.key)
        }
}
