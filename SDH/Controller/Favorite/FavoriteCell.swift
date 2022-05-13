//
//  FavoriteCell.swift
//  SDH
//
//  Created by Shaxzod Azamatjonov on 12/05/22.
//

import UIKit

class FavoriteCell: BaseTableViewCell<Results> {
    let tradeLabel = UILabel()
    let manufacturerLabel = UILabel()
    
    override func initView() {
        self.addSubview(tradeLabel)
        self.addSubview(manufacturerLabel)
        tradeLabel.text = "Trade Label"
        tradeLabel.numberOfLines = 0
        tradeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
        manufacturerLabel.text = "Manufacturer label"
        manufacturerLabel.numberOfLines = 0
        manufacturerLabel.snp.makeConstraints { make in
            make.top.equalTo(tradeLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
        }
    }
    override func updateUI(with model: Results) {
        manufacturerLabel.text = model.composition.description
        tradeLabel.text = model.trade_label.name
    }
}
