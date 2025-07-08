//
//  RegistrationViewController.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 05.06.2025.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class RegistrationViewController: UIViewController {

    lazy var backButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var signUpLabel : UILabel = {
        let label = UILabel()
        label.text = "Тіркелу"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var enterDataLabel : UILabel = {
        let label = UILabel()
        label.text = "Деректерді толтырыңыз"
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
    
    lazy var secondPasswordLabel : UILabel = {
        let label = UILabel()
        label.text = "Құпия сөзді қайталаңыз"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var secondPasswordTextField : UITextField = {
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
        button.addTarget(self, action: #selector(toggleSecondPasswordVisibility(sender:)), for: .touchUpInside)
        containerForButtonView.addSubview(button)
        textField.rightView = containerForButtonView
        textField.rightViewMode = .always
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    lazy var signUpButton : UIButton = {
        let button = UIButton()
        button.setTitle("Тіркелу", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.backgroundColor = UIColor(named: "7E2DFC")
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var signInSuggestionLabel: UILabel = {
        let label = UILabel()
        label.text = "Сізде аккаунт бар ма?"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "colorquestion")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var signInSuggestionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Кіру", for: .normal)
        button.setTitleColor(UIColor(named: "B376F7"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.addTarget(self, action: #selector(signInPage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "FFFFFF")
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        view.addSubview(signUpLabel)
        view.addSubview(backButton)
        view.addSubview(enterDataLabel)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signUpLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 124),
            signUpLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            enterDataLabel.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 5),
            enterDataLabel.leadingAnchor.constraint(equalTo: signUpLabel.leadingAnchor)
        ])
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(secondPasswordLabel)
        view.addSubview(secondPasswordTextField)
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: enterDataLabel.bottomAnchor, constant: 29),
            emailLabel.leadingAnchor.constraint(equalTo: enterDataLabel.leadingAnchor),
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 4),
            emailTextField.leadingAnchor.constraint(equalTo: enterDataLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 13),
            passwordLabel.leadingAnchor.constraint(equalTo: enterDataLabel.leadingAnchor),
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 4),
            passwordTextField.leadingAnchor.constraint(equalTo: enterDataLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            
            secondPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 13),
            secondPasswordLabel.leadingAnchor.constraint(equalTo: enterDataLabel.leadingAnchor),
            secondPasswordTextField.topAnchor.constraint(equalTo: secondPasswordLabel.bottomAnchor, constant: 4),
            secondPasswordTextField.leadingAnchor.constraint(equalTo: enterDataLabel.leadingAnchor),
            secondPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            secondPasswordTextField.heightAnchor.constraint(equalToConstant: 56),
            
        ])
      
        view.addSubview(signUpButton)
        view.addSubview(signInSuggestionLabel)
        view.addSubview(signInSuggestionButton)
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: secondPasswordTextField.bottomAnchor, constant: 40),
            signUpButton.leadingAnchor.constraint(equalTo: secondPasswordTextField.leadingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 56),
            signUpButton.trailingAnchor.constraint(equalTo: secondPasswordTextField.trailingAnchor),
            
            signInSuggestionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 110),
            signInSuggestionLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 24),
            signInSuggestionButton.leadingAnchor.constraint(equalTo: signInSuggestionLabel.trailingAnchor, constant: 5),
            signInSuggestionButton.centerYAnchor.constraint(equalTo: signInSuggestionLabel.centerYAnchor),
            
        ])
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChangeNotification), name: NSNotification.Name("LanguageChanged"), object: nil)
        localizeLanguage()
       
    }
    @objc func togglePasswordVisibility(sender: UIButton){
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry {
            sender.setImage(UIImage(named: "Show"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
        
    }
    
    @objc func toggleSecondPasswordVisibility(sender: UIButton) {
        secondPasswordTextField.isSecureTextEntry.toggle()
        if secondPasswordTextField.isSecureTextEntry {
            sender.setImage(UIImage(named: "Show"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
    @objc func backAction(){
        dismiss(animated: true)
    }

    
    @objc func signInPage(){
        let signInVC = AuthorizationViewController()
        signInVC.modalPresentationStyle = .fullScreen
        present(signInVC, animated: true)
    }
    
    @objc func signUpTapped(){
        let signUpEmail = emailTextField.text!
        let signUpPassword = passwordTextField.text!
        let confirmPassword = secondPasswordTextField.text!
        
        if signUpPassword == confirmPassword {
            SVProgressHUD.show()
            let parameters = ["email" : signUpEmail, "password" : signUpPassword]
            AF.request(Urls.SIGN_UP_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
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
                }   else {
                        var ErrorString = NSLocalizedString("CONNECTION_ERROR", comment: "")
                    if let sCode = response.response?.statusCode {
                        print("Status Code: \(sCode)")
                        ErrorString = ErrorString + "\(sCode)"
                    }
                    ErrorString = ErrorString + "\(resultString)"
                    SVProgressHUD.showError(withStatus: "\(ErrorString)")
                    }
                }
            print("Registration is successful")
        } else {
            showAlert(message: "Try again")
        }
        }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func startApp(){
        let tabViewController = TabBarController()
        tabViewController.modalPresentationStyle = .fullScreen
        self.present(tabViewController, animated: true, completion: nil)
    }
    
    func localizeLanguage(){
        signUpLabel.text = "SIGN_UP_LABEL".localized()
        signUpButton.setTitle("SIGN_UP_BUTTON".localized(), for: .normal)
        enterDataLabel.text = "DETAIL_INFORM_LABEL".localized()
        emailTextField.placeholder = "SIGN_UP_EMAIL".localized()
        passwordLabel.text = "CHANGE_PASSWORD_LABEL".localized()
        passwordTextField.placeholder = "ENTER_YOUR_PASSWORD".localized()
        secondPasswordLabel.text = "REPEAT_PASSWORD_LABEL".localized()
        secondPasswordTextField.placeholder = "ENTER_YOUR_PASSWORD".localized()
        signUpButton.setTitle("SIGN_UP_BUTTON".localized(), for: .normal)
        signInSuggestionLabel.text = "SIGN_UP_QUESTION_LABEL".localized()
        signInSuggestionButton.setTitle("SIGN_IN_BUTTON_UP".localized(), for: .normal)
    }
    @objc func languageDidChangeNotification() {
        localizeLanguage()
    }
    
}



