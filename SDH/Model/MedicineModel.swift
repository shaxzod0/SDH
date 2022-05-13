//
//  MedicineModel.swift
//  SDH
//
//  Created by Shaxzod Azamatjonov on 12/05/22.
//

import Foundation

struct MedicineModel: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Results]
}
struct Results: Codable {
    let id: Int
    let composition: Composition
    let trade_label: TradeLabel
}
struct Composition: Codable {
    let id: Int
    let description: String
}

struct TradeLabel: Codable {
    let id: Int
    let name: String
}

struct Manufacturer: Codable {
    let id: Int
    let name: String
    let country: Country
}
struct Country: Codable {
    let id: Int
    let name: String
    let iso2: String
    let iso3: String
}
