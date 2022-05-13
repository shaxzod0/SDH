//
//  Repository.swift
//  SDH
//
//  Created by Shaxzod Azamatjonov on 12/05/22.
//

import UIKit
import Alamofire

class Repository {
    static let shared = Repository()
    
    func getMedicine(page: Int, compilationHandler: @escaping((MedicineModel)->Void)){
        let url = AppUrl()
        AF.request("\(url.baseUrl)?page=\(page)").responseDecodable(of: MedicineModel.self) { res in
            guard let data = res.value else {
                print("Something wrong")
                return
            }
            compilationHandler(data)
        }
    }
}

