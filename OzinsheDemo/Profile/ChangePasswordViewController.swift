//
//  ChangePasswordViewController.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 13.06.2025.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    lazy var passwordLabel : UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        return label
    }()
    
    lazy var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: " Сіздің құпия сөзіңіз",
            attributes: [
                .foregroundColor: UIColor(named: "9CA3AF"),
                .font: UIFont(name: "SFProDisplay-Regular", size: 16)
            ]
        )
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let image = UIImageView(image: UIImage(named: "Password"))
        image.frame = CGRect(x: 10, y: 5, width: 20, height: 20)
        containerView.addSubview(image)
        textField.leftView = containerView
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        let containerForButtonView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Show"), for: .normal)
        button.tintColor = UIColor(named: "9CA3AF")
        button.frame = CGRect(x: 0, y: 5, width: 20, height: 20)
        button.addTarget(self, action: #selector(togglePasswordVisibility(sender:)), for: .touchUpInside)
        containerForButtonView.addSubview(button)
        textField.rightView = containerForButtonView
        textField.rightViewMode = .always
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var passwordRepeatLabel : UILabel = {
        let label = UILabel()
        label.text = "Құпия сөзді қайталаңыз"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        return label
    }()
    
    lazy var repeatPasswordTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: " Сіздің құпия сөзіңіз",
            attributes: [
                .foregroundColor: UIColor(named: "9CA3AF"),
                .font: UIFont(name: "SFProDisplay-Regular", size: 16)
            ]
        )
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let image = UIImageView(image: UIImage(named: "Password"))
        image.frame = CGRect(x: 10, y: 5, width: 20, height: 20)
        containerView.addSubview(image)
        textField.leftView = containerView
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        let containerForButtonView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Show"), for: .normal)
        button.tintColor = UIColor(named: "9CA3AF")
        button.frame = CGRect(x: 0, y: 5, width: 20, height: 20)
        button.addTarget(self, action: #selector(togglePasswordVisibility(sender:)), for: .touchUpInside)
        containerForButtonView.addSubview(button)
        textField.rightView = containerForButtonView
        textField.rightViewMode = .always
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
        navigationItem.title = "Құпия сөзді өзгерту"
        setupUI()
    }
    func setupUI(){
        view.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(21)
            make.left.equalToSuperview().offset(24)
        }
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        view.addSubview(passwordRepeatLabel)
        passwordRepeatLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(21)
            make.left.equalToSuperview().offset(24)
        }
        view.addSubview(repeatPasswordTextField)
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordRepeatLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-37)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
    
    @objc func togglePasswordVisibility(sender: UIButton){
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry {
            sender.setImage(UIImage(named: "Show"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
        
    }
}
