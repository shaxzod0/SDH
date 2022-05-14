//
//  SearchRepository.swift
//  SDH
//
//  Created by Shaxzod Azamatjonov on 14/05/22.
//

import Foundation
import Alamofire

class SearchRepository {
    static let shared = SearchRepository()
    func getInformation(medicineName: String, compilationHandler: @escaping((MedicineModel)->Void)){
        let url = AppUrl()
        AF.request("\(url.searchUrl)\(medicineName)").responseDecodable(of: MedicineModel.self) { res in
            guard let data = res.value else {
                print("Something wrong")
                return
            }
            compilationHandler(data)
        }
    }
}
