//
//  MainViewModel.swift
//  SDH
//
//  Created by Shaxzod Azamatjonov on 12/05/22.
//

import UIKit

class MainViewModel {
    var medicineItem: MedicineModel?
    var results: [Results] = []
    init() {
        getItems()
    }
    
    func getItems(){
        Repository.shared.getMedicine(page: 1) { res in
            self.medicineItem = res
            self.results = res.results
        }
    }
    func getItemsCount()->Int {
        return results.count
    }
    func isProductsEmpty() -> Bool {
        return results.isEmpty
    }
}
