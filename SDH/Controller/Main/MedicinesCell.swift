//
//  MedicinesCell.swift
//  SDH
//
//  Created by Shaxzod Azamatjonov on 12/05/22.
//

import UIKit

class MedicinesCell: BaseCollectionViewCell<Results> {
    let tradeLabel = UILabel()
    let manufacturerLabel = UILabel()
    
    override func initViews() {
        self.addSubview(tradeLabel)
        self.addSubview(manufacturerLabel)
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        tradeLabel.text = "Trade Label"
        tradeLabel.numberOfLines = 0
        tradeLabel.textColor = .black
        tradeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview().inset(20)
        }
        manufacturerLabel.text = "Manufacturer label"
        manufacturerLabel.textColor = .black
        manufacturerLabel.numberOfLines = 0
        manufacturerLabel.snp.makeConstraints { make in
            make.top.equalTo(tradeLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    override func updateUI(with model: Results) {
        tradeLabel.text = model.manufacturer?.name
        manufacturerLabel.text = model.trade_label?.name
    }
}
