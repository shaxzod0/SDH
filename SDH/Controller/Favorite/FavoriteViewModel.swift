//
//  FavoriteViewModel.swift
//  SDH
//
//  Created by Shaxzod Azamatjonov on 12/05/22.
//

import UIKit
import CoreData

struct CoreDataModel{
    let id: Int
    let tradeLabel: String
    let manafacturer: String
}
class FavoriteViewModel {
    var productData: [NSManagedObject] = [] {
        didSet {
            self.reloadTableView?()
        }
    }
    init(){
        fetchProducts()
    }
    func getProducts() -> [CoreDataModel] {
        var products: [CoreDataModel] = []
        for data in productData {
            let id = data.value(forKey: "id") as! Int
            let manufacturer = data.value(forKey: "manufacturer") as! String
            let tradeLabel = data.value(forKey: "tradeLabel") as! String
            products.append(CoreDataModel(id: id, tradeLabel: tradeLabel, manafacturer: manufacturer))
        }
        return products
    }
    
    func getProductCount() -> Int {
        return productData.count
    }
    func getProduct(index: Int) -> CoreDataModel {
        let id = productData[index].value(forKey: "id") as! Int
        let manufacturer = productData[index].value(forKey: "manufacturer") as! String
        let tradeLabel = productData[index].value(forKey: "tradeLabel") as! String
        let prodruct = CoreDataModel(id: id, tradeLabel: tradeLabel, manafacturer: manufacturer)
        return prodruct
    }
    func isProductsEmpty() -> Bool {
        return productData.isEmpty
    }
    func fetchProducts(){
        DataManager.shared.fetchFav { res in
            switch res{
            case .success(let data):
                self.productData = data
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    func deleteProduct(productId: Int) {
        DataManager.shared.deleteRecords(product: productId) { res in
            switch res{
            case .success(_):
                print("succes")
            case.failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    var reloadTableView: (()->())?
}
