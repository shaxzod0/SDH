//
//  InfoModule.swift
//  SDH
//
//  Created by Shaxzod Azamatjonov on 14/05/22.
//

import UIKit

class InfoModule {
    static func create(medicineId: Int) -> UIViewController{
        let dataManager = DataManager()
        let repository = InformationRepository()
        let vm = InfoViewModel(repository: repository, manager: dataManager, medicineId: medicineId)
        let vc = InfoController(vm: vm)
        return vc
    }
}
