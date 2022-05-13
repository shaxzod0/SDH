//
//  MainVC.swift
//  SDH
//
//  Created by Shaxzod Azamatjonov on 12/05/22.
//

import UIKit

class MainVC: BaseViewController {
    let viewModel = MainViewModel()
    let searchTF = UITextField()
    let searchButton = UIButton()
    weak var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        isLoading = viewModel.isProductsEmpty()
    }
    @objc override func retry() {
        self.isLoading = true
        self.noConnection = false
        print("tapped")
    }
}
extension MainVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    private func initViews() {
        view.addSubview(searchTF)
        view.addSubview(searchButton)
        searchTF.placeholder = "Enter medicine"
        searchTF.layer.cornerRadius = 15
        searchTF.backgroundColor = .white
        searchTF.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(55)
            make.left.equalToSuperview().offset(15)
        }
        searchButton.setTitle("Search", for: .normal)
        searchButton.snp.makeConstraints { make in
            make.left.equalTo(searchTF.snp.right).offset(10)
            make.centerY.equalTo(searchTF.snp.centerY)
        }
        let medicinesLayout = UICollectionViewFlowLayout()
        medicinesLayout.minimumLineSpacing = 10
        medicinesLayout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: medicinesLayout)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(MedicinesCell.self, forCellWithReuseIdentifier: MedicinesCell.reuseIdentifier)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchTF.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
        self.collectionView = collectionView
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getItemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedicinesCell.reuseIdentifier, for: indexPath) as! MedicinesCell
        viewModel.getItems()
        cell.updateUI(with: viewModel.results[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
