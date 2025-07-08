//
//  ChangePasswordViewController.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 13.06.2025.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

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
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor(named: "E5EBF0")?.cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = UIColor(named: "pwdchange")
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
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor(named: "E5EBF0")?.cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = UIColor(named: "pwdchange")
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
        button.addTarget(self, action: #selector(changePasswordAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "FFFFFF")
        navigationItem.title = "Құпия сөзді өзгерту"
        setupUI()
        localizeLanguage()
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
    
    @objc func changePasswordAction(){
        let newPassword = passwordTextField.text!
        let repeatPassword = repeatPasswordTextField.text!
        
        if newPassword != repeatPassword {
            SVProgressHUD.showError(withStatus: "Пароли должны совпадать!")
            return
        }
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"]
        let parameters = ["password": newPassword]
        AF.request(Urls.CHANGE_PASSWORD, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
            }
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
                if let token = json["accessToken"].string {
                    Storage.sharedInstance.accessToken = token
                    UserDefaults.standard.set(token, forKey: "accessToken")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    var ErrorString = NSLocalizedString("CONNECTION_ERROR", comment: "")
                    if let sCode = response.response?.statusCode {
                        print("Status Code: \(sCode)")
                        ErrorString = ErrorString + "\(sCode)"
                    }
                    ErrorString = ErrorString + "\(resultString)"
                    SVProgressHUD.showError(withStatus: "\(ErrorString)")
                }
            }
        }
    }
    func localizeLanguage() {
           navigationItem.title = "CHANGE_PASSWORD_NAVIGATION".localized()
           passwordLabel.text = "CHANGE_PASSWORD_LABEL".localized()
           passwordRepeatLabel.text = "REPEAT_PASSWORD_LABEL".localized()
        passwordTextField.placeholder = "ENTER_YOUR_PASSWORD".localized()
        repeatPasswordTextField.placeholder = "ENTER_YOUR_PASSWORD".localized()
           saveButton.setTitle("US_INFO_SAVE_BUTTON".localized(), for: .normal)
    }
}
