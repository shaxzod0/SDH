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
    let searchButton = RectButton(image: nil, title: "Search", frame: .zero)
    weak var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        isLoading = !viewModel.isProductsEmpty()
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

        searchButton.addTarget(self, action: #selector(searchMedicine), for: .touchUpInside)
        searchButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(searchTF.snp.centerY)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        searchTF.placeholder = "Enter medicine"
        searchTF.layer.cornerRadius = 15
        searchTF.backgroundColor = .white
        searchTF.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(55)
            make.left.equalToSuperview().offset(15)
            make.right.equalTo(searchButton.snp.left).inset(-10)
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
        viewModel.reloadCollectionViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionView?.reloadData()
            }
        }
    }
    @objc func searchMedicine() {
        guard let name = searchTF.text else{ return }
        viewModel.searchedItems(medicineName: name)
        if viewModel.getItemsCount() == 0 {
            medicineNotFound()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getItemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedicinesCell.reuseIdentifier, for: indexPath) as! MedicinesCell
        cell.updateUI(with: viewModel.getProduct(index: indexPath.item))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 40
        return CGSize(width: width, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = InfoModule.create(medicineId: viewModel.getProduct(index: indexPath.item).id)
        navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.getItemsCount() - 1{
            viewModel.pageCount += 1
            viewModel.getItems()
        }else{
            
        }
    }
    func medicineNotFound(){
        let alert = UIAlertController(title: "Medicine not found", message: "Sorry we can't find", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
