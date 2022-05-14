//
//  MainViewModel.swift
//  SDH
//
//  Created by Shaxzod Azamatjonov on 12/05/22.
//

import UIKit

class MainViewModel {
  
    var medicineItem: MedicineModel?
    var pageCount = 1
    var results: [Results] = [] {
        didSet{
            self.reloadCollectionViewClosure?()
        }
    }
    init() {
        getItems()
    }
    func getItemsCount()->Int {
        return results.count
    }
    
    func getItems(){
        Repository.shared.getMedicine(page: pageCount) { res in
            self.medicineItem = res
            if self.pageCount == 1 {
                self.results = res.results
            }
            else{
                self.results += res.results
            }
        }
    }
    func getProduct(index: Int)->Results{
        let id = results[index].id
        let trade = results[index].trade_label
        let comp = results[index].composition
        let man = results[index].manufacturer
        let packaging = results[index].packaging
        let product = Results(id: id, composition: comp, trade_label: trade, manufacturer: man, packaging: packaging)
        return product
    }

    func isProductsEmpty() -> Bool {
        return results.isEmpty
    }
    func searchedItems(medicineName: String){
        SearchRepository.shared.getInformation(medicineName: medicineName) { res in
            self.medicineItem = res
            self.results = res.results
        }
    }
    var reloadCollectionViewClosure: (()->())?
}
