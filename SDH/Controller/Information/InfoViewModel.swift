//
//  InfoViewModel.swift
//  SDH
//
//  Created by Shaxzod Azamatjonov on 13/05/22.
//

import UIKit

class InfoViewModel {
    private var medicineId: Int
    private var medicineModel: Results? {
        didSet {
            guard let _ = medicineModel else { return }
            self.updateUI!()
        }
    }
    var dataManager: DataManager
    var repository: InformationRepository
    
    var updateUI: (()->())?

    func getMedicineData() -> Results? {
        return medicineModel
    }
    
    init(repository: InformationRepository, manager: DataManager, medicineId: Int){
        self.repository = repository
        self.dataManager = manager
        self.medicineId = medicineId
    }
    
    func getInfo(){
        repository.getInformation(id: medicineId) { res in
            self.medicineModel = res
        }
    }
    func checkingAvailability() -> String{
        if dataManager.checkItemExist(id: medicineId){
            return "Delete"
        }else{
            return "Save"
        }
    }
    @objc func saveData() {
        dataManager.saveToFav(product: medicineModel!) { res in
            switch res{
            case .success(_):
                print("cart")
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    @objc func deleteData() {
        dataManager.deleteRecords(product: medicineModel!.id) { res in
            switch res {
            case .success(_):
                print("deleted")
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
