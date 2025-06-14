//
//  UserInfoViewController.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 12.06.2025.
//

import UIKit
import SnapKit

class UserInfoViewController: UIViewController {
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Сіздің атыңыз"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        return label
    }()
    lazy var nameTextField : UITextField = {
        let textfield = UITextField()
        return textfield
    }()
    
    lazy var emailLabel : UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        return label
    }()
    lazy var emailTextField : UITextField = {
        let textfield = UITextField()
        return textfield
    }()
    
    lazy var phoneLabel : UILabel = {
        let label = UILabel()
        label.text = "Телефон"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        return label
    }()
    lazy var phoneTextField : UITextField = {
        let textfield = UITextField()
        return textfield
    }()
    
    lazy var birthdayLabel : UILabel = {
        let label = UILabel()
        label.text = "Туылған күніңіз"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        return label
    }()
    lazy var birthdayTextField : UITextField = {
        let textfield = UITextField()
        return textfield
    }()
    
    lazy var saveButton : UIButton = {
        let button = UIButton()
        button.setTitle("Өзгерістерді сақтау", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(named: "7E2DFC")
        return button
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Жеке деректер"
        setupUI()
    }
    
    func addLine(textfield: UITextField){
        let line = CALayer()
        line.backgroundColor = UIColor(named: "D1D5DB")?.cgColor
        line.frame = CGRect(x: 0, y: textfield.frame.height-1, width: textfield.frame.width, height: 1)
        textfield.layer.addSublayer(line)
    }
    
    func setupUI(){
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(phoneLabel)
        view.addSubview(phoneTextField)
        view.addSubview(birthdayLabel)
        view.addSubview(birthdayTextField)
        view.addSubview(saveButton)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(24)
            make.left.equalToSuperview().inset(24)
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(40)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(40)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
        }
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(40)
        }
        
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(24)
        }
        birthdayTextField.snp.makeConstraints { make in
            make.top.equalTo(birthdayLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(40)
        }
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-37)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addLine(textfield: nameTextField)
        addLine(textfield: emailTextField)
        addLine(textfield: phoneTextField)
        addLine(textfield: birthdayTextField)
    }
    
    func hideKeyboardWhenTappedAround(){
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    

}
