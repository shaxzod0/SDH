//
//  FavoriteController.swift
//  SDH
//
//  Created by Shaxzod Azamatjonov on 12/05/22.
//

import UIKit

class FavoriteController: UIViewController {
    let viewModel = FavoriteViewModel()
    let tableView = UITableView()
    let emptyLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        view.backgroundColor = .lightGray
        emptyLabel.isHidden = !viewModel.isProductsEmpty()
    }
}

extension FavoriteController: UITableViewDelegate, UITableViewDataSource{

    
    private func initView() {
        view.addSubview(emptyLabel)
        emptyLabel.text = "Not favorite products"
        emptyLabel.font = .systemFont(ofSize: 25, weight: .bold)
        emptyLabel.textAlignment = .center
        emptyLabel.numberOfLines = 0
        emptyLabel.textColor = .red
        emptyLabel.isHidden = false
        emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseIdentifier)
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getProductCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseIdentifier, for: indexPath) as! FavoriteCell
        cell.updateUI(with: viewModel.getProduct(index: indexPath.item))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = InfoModule.create(medicineId: viewModel.getProduct(index: indexPath.item).id)
        navigationController?.pushViewController(vc, animated: true)
    }
}
