//
//  LanguageViewController.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 14.06.2025.
//

import UIKit
import SnapKit
import Localize_Swift

protocol LanguageProtocol {
    func languageDidChange()
}

class LanguageViewController: UIViewController, UIGestureRecognizerDelegate {
    var delegate : LanguageProtocol?
    let languages = [["English", "en"], ["Қазақша", "kk"], ["Русский", "ru"]]
    var selectedLanguage = Localize.currentLanguage()

    
    lazy var whiteView: UIView = {
        let whiteview = UIView()
        whiteview.backgroundColor = UIColor(named: "smallviewcolor")
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
    
    lazy var languageLabel : UILabel = {
        let label = UILabel()
        label.text = "Тіл"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.isScrollEnabled = false
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        tapGesture()
    }
    
    func setupUI(){
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        view.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(330)
        }
        
        whiteView.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.centerX.equalToSuperview()
            make.width.equalTo(64)
            make.height.equalTo(5)
        }
        whiteView.addSubview(languageLabel)
        languageLabel.snp.makeConstraints { make in
            make.top.equalTo(homeView.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(24)
        }
        whiteView.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LanguageTableViewCell.self, forCellReuseIdentifier: "LanguageCell")
        tableView.snp.makeConstraints { make in
            make.top.equalTo(languageLabel.snp.bottom).offset(32)
            make.left.right.equalToSuperview()
            make.height.equalTo(190)
        }
    }

    func tapGesture(){
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
           if touch.view is UITableView || touch.view?.superview is UITableViewCell {
               return false
           }
           return true
       }
    
}

extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let language = languages[indexPath.row][0]
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageTableViewCell
        cell.languageLabel.text = language
        let languageCode = languages[indexPath.row][1]
        cell.setChecked(languageCode == selectedLanguage)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLanguage = languages[indexPath.row][0]
        Localize.setCurrentLanguage(languages[indexPath.row][1])
        delegate?.languageDidChange()
        NotificationCenter.default.post(name: NSNotification.Name("LanguageChanged"), object: nil)
        dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}
