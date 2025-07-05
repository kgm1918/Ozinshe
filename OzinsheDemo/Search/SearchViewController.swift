//
//  SearchViewController.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 03.06.2025.
//

import UIKit
import SnapKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class LeftAlignedCollectionViewFlowLayout : UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach{ layoutAttribute in
            guard layoutAttribute.representedElementCategory == .cell else
            {
                return
            }
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDataSource, UITableViewDelegate {
    
    var categories : [Category] = []
//    ["Телехикая", "Ситком", "Көркем фильм", "Мультфильм", "Мультсериал", "Аниме", "Тв-бағдарлама және реалити-шоу", "Деректі фильм", "Музыка", "Шетел фильмдері"]
    var movies : [Movie] = []
    
    lazy var searchTextField : UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString(
            string: "Іздеу",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "9CA3AF")!,
                         NSAttributedString.Key.font : UIFont(name: "SFProDisplay-Semibold", size: 16)!
                        ]
            )
        textfield.layer.borderColor = UIColor(named: "F3F4F6")?.cgColor
        textfield.layer.borderWidth = 1
        textfield.layer.cornerRadius = 12
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textfield.leftViewMode = .always
        textfield.delegate = self
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    lazy var exitButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Exit"), for: .normal)
        button.contentMode = .scaleToFill
        button.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var searchButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Search-icon"), for: .normal)
        button.backgroundColor = UIColor(named: "F3F4F6")
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var categoriesLabel : UILabel = {
        let label = UILabel()
        label.text = "Санаттар"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 128, height: 34)
        layout.estimatedItemSize.width = 100
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: "collectionViewColor")
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let tableView : UITableView = {
        let tableview = UITableView()
        tableview.separatorStyle = .none
        tableview.allowsSelection = true
        tableview.showsVerticalScrollIndicator = false
        tableview.showsHorizontalScrollIndicator = false
        tableview.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableCell")
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "FFFFFF")
        navigationItem.title = "Іздеу"
        navigationController?.navigationBar.tintColor = UIColor(named: "blackcolor")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.dataSource = self
        tableView.delegate = self
        setupUI()
        exitButton.isHidden = true
        hideKeyboardWhenTappedAround()
        tableView.isHidden = true
        downloadCategories()
    }
    
    func downloadCategories(){
        SVProgressHUD.show()
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"]
        AF.request(Urls.CATEGORIES_URL, method: .get, headers: headers).responseData { response in
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
//                print("CATEGORY")
//                print("JSON: \(json)")
                if let array = json.array {
                    for item in array {
                        let category = Category(json: item)
                        self.categories.append(category)
                    }
                    self.collectionView.reloadData()
                } else {
                    SVProgressHUD.showError(withStatus: NSLocalizedString("CONNECTION_ERROR", comment: ""))
                }
        }
            else {
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
    
    func downloadSearchMovies(){
        if searchTextField.text!.isEmpty {
            categoriesLabel.text = "Санаттар"
            collectionView.isHidden = false
            tableView.isHidden = true
            movies.removeAll()
            tableView.reloadData()
            exitButton.isHidden = true
            
            tableView.snp.remakeConstraints { make in
                make.top.equalTo(collectionView.snp.bottom)
                make.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
            }
            return
        } else {
            categoriesLabel.text = "Іздеу нәтижелері"
            collectionView.isHidden = true
            tableView.snp.makeConstraints { make in
                make.top.equalTo(categoriesLabel.snp.bottom).offset(10)
                make.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
            }
            tableView.isHidden = false
            exitButton.isHidden = false
        }
        SVProgressHUD.show()
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"]
        let parameters = ["search" : searchTextField.text!]
        AF.request(Urls.SEARCH_MOVIES_URL, method: .get, parameters: parameters, headers: headers).responseData { response in
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
//                print("JSON: \(json)")
                if let array = json.array {
                    self.movies.removeAll()
                    self.tableView.reloadData()
                    for item in array {
                        let movie = Movie(json: item)
                        self.movies.append(movie)
                    }
                    self.tableView.reloadData()
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
   
    func hideKeyboardWhenTappedAround(){
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func clearTextField(){
        searchTextField.text = ""
        downloadSearchMovies()
    }
    
    @objc func searchButtonTapped(){
        downloadSearchMovies()
    }
    
    func setupUI(){
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(categoriesLabel)
        view.addSubview(collectionView)
        view.addSubview(exitButton)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 124),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -96),
            searchTextField.heightAnchor.constraint(equalToConstant: 56),
            
            exitButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            exitButton.trailingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: -18),
            exitButton.widthAnchor.constraint(equalToConstant: 20),
            exitButton.heightAnchor.constraint(equalToConstant: 20),
            
            searchButton.leadingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 16),
            searchButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 56),
            searchButton.heightAnchor.constraint(equalToConstant: 56),
            
            categoriesLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 35),
            categoriesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            collectionView.topAnchor.constraint(equalTo: categoriesLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 340),
            
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        cell.label.text = categories[indexPath.row].name
        cell.backView.layer.cornerRadius = 8
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let categoryTableViewController = CategoryTableViewController()
        categoryTableViewController.categoryID = categories[indexPath.row].id
        categoryTableViewController.categoryName = categories[indexPath.row].name
        navigationController?.show(categoryTableViewController, sender: self)
        navigationItem.title = ""
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableCell", for: indexPath) as! MovieTableViewCell
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153.0
    }
    
}


extension SearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == searchTextField {
            searchTextField.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == searchTextField {
            searchTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        }
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        downloadSearchMovies()
    }
   
}
