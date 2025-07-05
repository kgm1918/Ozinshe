//
//  AuthorizationViewController.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 04.06.2025.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD

class AuthorizationViewController: UIViewController {
    lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var salemLabel : UILabel = {
        let label = UILabel()
        label.text = "Сәлем"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var signinLabel : UILabel = {
        let label = UILabel()
        label.text = "Аккаунтқа кіріңіз"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        label.textColor = UIColor(named: "6B7280")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailLabel : UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var passwordLabel : UILabel = {
        let label = UILabel()
        label.text = "Құпия сөз"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: " Сіздің email",
            attributes: [
                .foregroundColor: UIColor(named: "9CA3AF"),
                .font: UIFont(name: "SFProDisplay-Regular", size: 16)
            ]
        )
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let image = UIImageView(image: UIImage(named: "Message"))
        image.frame = CGRect(x: 10, y: 5, width: 20, height: 20)
        containerView.addSubview(image)
        textField.leftView = containerView
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor(named: "E5EBF0")?.cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = UIColor(named: "pwdchange")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
    
    lazy var forgotButton : UIButton = {
        let button = UIButton()
        button.setTitle("Құпия сөзді ұмыттыңыз ба?", for: .normal)
        button.setTitleColor(UIColor(named: "B376F7"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.contentHorizontalAlignment = .right
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var signinButton : UIButton = {
        let button = UIButton()
        button.setTitle("Кіру", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.backgroundColor = UIColor(named: "7E2DFC")
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var signUpSuggestionLabel: UILabel = {
        let label = UILabel()
        label.text = "Аккаунтыңыз жоқ па?"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "colorquestion")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var signUpSuggestionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Тіркелу", for: .normal)
        button.setTitleColor(UIColor(named: "B376F7"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.addTarget(self, action: #selector(signUpPage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var orLabel : UILabel = {
        let label = UILabel()
        label.text = "Немесе"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var appleIDButton : UIButton = {
        let button = UIButton()
        button.setTitle(" Apple ID-мен тіркеліңіз", for: .normal)
        button.setTitleColor(UIColor(named: "applegoogletext"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.layer.borderColor = UIColor(named: "D1D5DB")?.cgColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = UIColor(named: "applegoogle")
        button.layer.cornerRadius = 8
        button.setImage(UIImage(named: "apple-logo"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var googleButton : UIButton = {
        let button = UIButton()
        button.setTitle(" Google-мен тіркеліңіз", for: .normal)
        button.setTitleColor(UIColor(named: "applegoogletext"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.layer.borderColor = UIColor(named: "D1D5DB")?.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(named: "applegoogle")
        button.setImage(UIImage(named: "google-logo"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "FFFFFF")
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        view.addSubview(salemLabel)
        view.addSubview(backButton)
        view.addSubview(signinLabel)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            salemLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 124),
            salemLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            signinLabel.topAnchor.constraint(equalTo: salemLabel.bottomAnchor, constant: 5),
            signinLabel.leadingAnchor.constraint(equalTo: salemLabel.leadingAnchor)
        ])
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: signinLabel.bottomAnchor, constant: 29),
            emailLabel.leadingAnchor.constraint(equalTo: signinLabel.leadingAnchor),
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 4),
            emailTextField.leadingAnchor.constraint(equalTo: signinLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 13),
            passwordLabel.leadingAnchor.constraint(equalTo: signinLabel.leadingAnchor),
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 4),
            passwordTextField.leadingAnchor.constraint(equalTo: signinLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
        ])
        view.addSubview(forgotButton)
        NSLayoutConstraint.activate([
            forgotButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 17),
            forgotButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            forgotButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor)
        ])
        view.addSubview(signinButton)
        view.addSubview(orLabel)
        view.addSubview(signUpSuggestionLabel)
        view.addSubview(signUpSuggestionButton)
        NSLayoutConstraint.activate([
            signinButton.topAnchor.constraint(equalTo: forgotButton.bottomAnchor, constant: 40),
            signinButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            signinButton.heightAnchor.constraint(equalToConstant: 56),
            signinButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
            signUpSuggestionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 110),
            signUpSuggestionLabel.topAnchor.constraint(equalTo: signinButton.bottomAnchor, constant: 24),
            signUpSuggestionButton.leadingAnchor.constraint(equalTo: signUpSuggestionLabel.trailingAnchor, constant: 5),
            signUpSuggestionButton.centerYAnchor.constraint(equalTo: signUpSuggestionLabel.centerYAnchor),
            
            orLabel.topAnchor.constraint(equalTo: signUpSuggestionLabel.bottomAnchor, constant: 40),
            orLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            orLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor)
        ])
        view.addSubview(appleIDButton)
        view.addSubview(googleButton)
        NSLayoutConstraint.activate([
            appleIDButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 16),
            appleIDButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            appleIDButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            appleIDButton.heightAnchor.constraint(equalToConstant: 52),
            
            googleButton.topAnchor.constraint(equalTo: appleIDButton.bottomAnchor, constant: 8),
            googleButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            googleButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            googleButton.heightAnchor.constraint(equalToConstant: 52),
        ])
       
    }
    @objc func togglePasswordVisibility(sender: UIButton){
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry {
            sender.setImage(UIImage(named: "Show"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
        
    }
    
    @objc func backAction(){
        dismiss(animated: true)
    }
    
    @objc func signUpPage(){
        let signUpVC = RegistrationViewController()
        signUpVC.modalPresentationStyle = .fullScreen
        present(signUpVC, animated: true)
    }
    
    @objc func signInTapped() {
            let email = emailTextField.text!
            let password = passwordTextField.text!
            
            SVProgressHUD.show()
            let parameters = ["email" : email, "password" : password]
            AF.request(Urls.SIGN_IN_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
                SVProgressHUD.dismiss()
                var resultString = ""
                if let data = response.data {
                    resultString = String(data: data, encoding: .utf8)!
                    print(resultString)
                }
                if response.response?.statusCode == 200 {
                    let json = JSON(response.data!)
                    print("JSON: \(json)")
                    if let token = json["accessToken"].string {
                        Storage.sharedInstance.accessToken = token
                        UserDefaults.standard.set(token, forKey: "accessToken")
                        self.startApp()
                    } else {
                            SVProgressHUD.showError(withStatus: NSLocalizedString("CONNECTION_ERROR", comment: ""))
                    }
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
    func startApp(){
        let tabViewController = TabBarController()
        tabViewController.modalPresentationStyle = .fullScreen
        self.present(tabViewController, animated: true, completion: nil)
    }

}
