//
//  InfoController.swift
//  SDH
//
//  Created by Shaxzod Azamatjonov on 12/05/22.
//

import UIKit
import SnapKit
class InfoController: BaseViewController {
    
    var medicineId: Int? = nil
    var viewModel: InfoViewModel
    let saveButton = RectButton(image: nil, title: "Save", frame: .zero)
    let informationView = UIStackView()
    let tradeLabel = UILabel()
    let manufacturerName = UILabel()
    let packagingDesc = UILabel()
    let compositionDesc = UILabel()
    let compositionInn = UILabel()
    let compositionPharmForm = UILabel()
    
    init(vm: InfoViewModel) {
        viewModel = vm
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getInfo()
    }
}

extension InfoController {
    private func initViews() {
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(55)
        }
        view.addSubview(informationView)
        informationView.layer.cornerRadius = 15
        informationView.backgroundColor = .white
        informationView.axis = .vertical
        informationView.distribution = .fillEqually
        informationView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.7)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.center.equalToSuperview()
        }

        
        informationView.addArrangedSubview(tradeLabel)
        informationView.addArrangedSubview(manufacturerName)
        informationView.addArrangedSubview(packagingDesc)
        informationView.addArrangedSubview(compositionDesc)
        informationView.addArrangedSubview(compositionInn)
        informationView.addArrangedSubview(compositionPharmForm)
        tradeLabel.numberOfLines = 0
        manufacturerName.numberOfLines = 0
        packagingDesc.numberOfLines = 0
        compositionDesc.numberOfLines = 0
        compositionInn.numberOfLines = 0
        compositionPharmForm.numberOfLines = 0
        viewModel.updateUI = { [unowned self] () in
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    func updateUI() {
        guard let data = viewModel.getMedicineData() else { return }
        tradeLabel.text = data.trade_label?.name
        manufacturerName.text = data.manufacturer?.name
        packagingDesc.text = data.packaging?.composition.description
        compositionDesc.text = data.composition?.description
        compositionInn.text = data.composition?.inn.name
        compositionPharmForm.text = data.composition?.pharm_form.name
        saveButton.initView(image: nil, title: viewModel.checkingAvailability())
    }
}
