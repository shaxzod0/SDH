//
//  BaseViewController.swift
//  SDH
//
//  Created by Shaxzod Azamatjonov on 12/05/22.
//

import UIKit
import Reachability
import SnapKit

class BaseViewController: UIViewController {
    
    var reachability: Reachability?
    var loadingView: UIView = .init()
    let noConnectionView: UIView = .init()
    var loadingText: String?
    
   
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            reachability = try Reachability()
        } catch {
            
        }
        reachability?.whenReachable = { reach in
            if reach.connection == .wifi {
                self.noConnection = false
            } else {
                self.noConnection = false
            }
        }
        reachability?.whenUnreachable = { _ in
            self.noConnection = true
        }
        do {
            try reachability?.startNotifier()
        }
        catch{
            print("Unable to start reachability")
        }
        
        
        view.backgroundColor = .lightGray
        var indicator: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            indicator = .init(style: .large)
        } else {
            indicator = .init(style: .gray)
        }
        indicator.startAnimating()
        loadingView.addSubview(indicator)
        
        let loadingLabel: UILabel = .init()
        loadingLabel.text = loadingText
        loadingLabel.font = .systemFont(ofSize: 15)
        loadingLabel.textColor = .gray
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(loadingLabel)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.isHidden = true
        view.addSubview(loadingView)
        
        loadingView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        indicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        loadingLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(indicator.snp.bottom).offset(20)
        }
        
        let noConnectionImageView: UIImageView = .init(image: UIImage(named: "icon_no_connection"))
        noConnectionImageView.translatesAutoresizingMaskIntoConstraints = false
        noConnectionView.addSubview(noConnectionImageView)
        
        let noConnectionLabel: UILabel = .init()
        noConnectionLabel.font = .systemFont(ofSize: 12)
        noConnectionLabel.textColor = .gray
        noConnectionLabel.text = "Check your connection"
        noConnectionLabel.translatesAutoresizingMaskIntoConstraints = false
        noConnectionLabel.numberOfLines = 0
        noConnectionLabel.textAlignment = .center
        noConnectionView.addSubview(noConnectionLabel)
        
        let noConnectionButton: UIButton = RectButton(image: nil, title: "Retry", frame: .zero)
        noConnectionButton.addTarget(self, action: #selector(retry), for: .touchUpInside)
        noConnectionView.addSubview(noConnectionButton)
        noConnectionView.translatesAutoresizingMaskIntoConstraints = false
        noConnectionView.isHidden = true
        view.addSubview(noConnectionView)
        noConnectionView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(250)
        }
        
        noConnectionImageView.snp.makeConstraints { make in
            make.top.equalTo(noConnectionView.snp.top)
            make.centerX.equalTo(noConnectionView.snp.centerX)
        }
        noConnectionLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(noConnectionImageView.snp.bottom)
        }
        noConnectionButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(noConnectionLabel.snp.bottom).offset(10)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        try? reachability?.startNotifier()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        reachability?.stopNotifier()
    }
    
    var isLoading: Bool = false {
        didSet {
            loadingView.isHidden = !isLoading
        }
    }
    var noConnection: Bool = false {
        didSet {
            noConnectionView.isHidden = !noConnection
        }
    }
    @objc func retry() {
        
    }
}
