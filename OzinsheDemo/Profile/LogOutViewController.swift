//
//  LogOutViewController.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 14.06.2025.
//

import UIKit

class LogOutViewController: UIViewController {
    
    lazy var whiteView: UIView = {
        let whiteview = UIView()
        whiteview.backgroundColor = .white
        whiteview.layer.cornerRadius = 32
        whiteview.clipsToBounds = true
        return whiteview
    }()
    
    lazy var homeView : UIView = {
        let homeview = UIView()
        homeview.backgroundColor = UIColor(named: "D1D5DB")
        homeview.layer.cornerRadius = 3
        return homeview
    }()
    
    lazy var exitLabel : UILabel = {
        let label = UILabel()
        label.text = "Шығу"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        return label
    }()
    
    lazy var subtitleLabel : UILabel = {
        let label = UILabel()
        label.text = "Сіз шынымен аккаунтыңыздан"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        label.textColor = UIColor(named: "9CA3AF")
        return label
    }()
    
    lazy var yesButton : UIButton = {
        let button = UIButton()
        button.setTitle("Иә, шығу", for: .normal)
        button.setTitleColor(UIColor(named: "5415C6"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.addTarget(self, action: #selector(yesSelected), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    lazy var noButton : UIButton = {
        let button = UIButton()
        button.setTitle("Жоқ", for: .normal)
        button.setTitleColor(UIColor(named: "5415C6"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.addTarget(self, action: #selector(noSelected), for: .touchUpInside)
        button.layer.cornerRadius = 12
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI(){
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(330)
        }
        
        whiteView.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.centerX.equalToSuperview()
            make.width.equalTo(64)
            make.height.equalTo(5)
        }
        whiteView.addSubview(exitLabel)
        exitLabel.snp.makeConstraints { make in
            make.top.equalTo(homeView.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
        }
        whiteView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(exitLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(24)
        }
        
        whiteView.addSubview(yesButton)
        yesButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        whiteView.addSubview(noButton)
        noButton.snp.makeConstraints { make in
            make.top.equalTo(yesButton.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
    
    @objc func yesSelected(){
        yesButton.backgroundColor = UIColor(named: "7E2DFC")
        yesButton.setTitleColor(.white, for: .normal)
        noButton.backgroundColor = .clear
        noButton.setTitleColor(UIColor(named: "5415C6"), for: .normal)
    }
    
    @objc func noSelected(){
        noButton.backgroundColor = UIColor(named: "7E2DFC")
        noButton.setTitleColor(.white, for: .normal)
        yesButton.backgroundColor = .clear
        yesButton.setTitleColor(UIColor(named: "5415C6"), for: .normal)
        self.dismiss(animated: true)
    }

}
