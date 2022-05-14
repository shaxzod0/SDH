//
//  InformationRepository.swift
//  SDH
//
//  Created by Shaxzod Azamatjonov on 13/05/22.
//

import UIKit
import Alamofire

class InformationRepository {

    func getInformation(id: Int, compilationHandler: @escaping((Results)->Void)){
        let url = AppUrl()
        AF.request("\(url.baseUrl)\(id)").responseDecodable(of: Results.self) { res in
            guard let data = res.value else {
                print("Something wrong")
                return
            }
            compilationHandler(data)
        }
    }
}
