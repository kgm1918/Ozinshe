//
//  ProfileViewController.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 03.06.2025.
//

import UIKit
import SnapKit

enum sectionTypes {
    case buttonType
    case switchType
}

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    lazy var profileImageView : UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "avatar")
        return imageview
    }()
    
    lazy var profileLabel : UILabel = {
        let label = UILabel()
        label.text = "Менің профилім"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        return label
    }()
    
    lazy var subtitleProfileLabel = {
        let label = UILabel()
        label.text = "ali@gmail.com"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        return label
    }()
    
    lazy var exitButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "exit"), for: .normal)
        button.addTarget(self, action: #selector(exitApp), for: .touchUpInside)
        return button
    }()
    
    lazy var tableView : UITableView = {
        let tableview = UITableView()
        tableview.separatorStyle = .none
        tableview.backgroundColor = UIColor(named: "F9FAFB")
        tableview.delegate = self
        tableview.dataSource = self
        return tableview
    }()
    
    var sections : [sectionTypes] = [.buttonType, .switchType]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Профиль"
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: exitButton)
        setupUI()
    }
    
    func setupUI(){
        view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
        view.addSubview(profileLabel)
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        view.addSubview(subtitleProfileLabel)
        subtitleProfileLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileLabel.snp.bottom).offset(8)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(subtitleProfileLabel.snp.bottom).offset(24)
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section]{
        case .buttonType : return 4
        case .switchType: return 2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sections[indexPath.section] {
        case .buttonType :
            if indexPath.row == 0 {
                let userInfoVC = UserInfoViewController()
                navigationController?.pushViewController(userInfoVC, animated: true)
            } else if indexPath.row == 1 {
                let changePasswordVC = ChangePasswordViewController()
                navigationController?.pushViewController(changePasswordVC, animated: true)
            } else if indexPath.row == 2 {
                let languageVC = LanguageViewController()
                languageVC.modalPresentationStyle = .overFullScreen
                languageVC.modalTransitionStyle = .crossDissolve
                present(languageVC, animated: true)
            }
        case .switchType: break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        switch sections[indexPath.section]{
        case .buttonType:
            let titles = ["Жеке деректер", "Құпия сөзді өзгерту", "Тіл", "Ережелер мен шарттар"]
            let rightText = ["Өңдеу", "", "Қазақша", ""]
            cell.textLabel?.text = titles[indexPath.row]
            cell.accessoryType = .disclosureIndicator
            cell.detailTextLabel?.text = rightText[indexPath.row]
            cell.selectionStyle = .default
        case .switchType:
            let titles = ["Хабарландырулар", "Қараңғы режим"]
            cell.textLabel?.text = titles[indexPath.row]
            let toggle = UISwitch()
            toggle.isOn = false
            toggle.tag = indexPath.row
            cell.accessoryView = toggle
            cell.selectionStyle = .none

        }
        let separator = UIView()
        separator.backgroundColor = UIColor(named: "D1D5DB")
        cell.addSubview(separator)

        separator.snp.makeConstraints { make in
            make.left.equalTo(cell).inset(24)
            make.right.equalTo(cell).inset(24)
            make.bottom.equalTo(cell)
            make.height.equalTo(1)
        }

        return cell
    }
    
    @objc func exitApp(){
        let logoutVC = LogOutViewController()
        logoutVC.modalPresentationStyle = .overFullScreen
        logoutVC.modalTransitionStyle = .crossDissolve
        present(logoutVC, animated: true)
    }
    
}
