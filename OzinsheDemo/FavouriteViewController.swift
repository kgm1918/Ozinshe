//
//  FavouriteViewController.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 03.06.2025.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
import Alamofire

class FavouriteViewController: UITableViewController {
    var favMovies : [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFavorites), name: NSNotification.Name("FavoritesUpdated"), object: nil)
        view.backgroundColor = UIColor(named: "FFFFFF")
        tableView.separatorStyle = .none
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableCell")
        downloadFavouriteMovies()
        localizeLanguage()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableCell", for: indexPath) as! MovieTableViewCell
        cell.configure(with: favMovies[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
    }
    
   
    func downloadFavouriteMovies(){
        SVProgressHUD.show()
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"]
        AF.request(Urls.FAVORITE_URL, method: .get, headers: headers).responseData { response in
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
            }
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                if let array = json.array {
                    self.favMovies.removeAll()
                    for item in array {
                        let favMovie = Movie(json: item)
                        self.favMovies.append(favMovie)
                    }
                    self.tableView.reloadData()
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
    @objc func reloadFavorites() {
        downloadFavouriteMovies()
    }
    func localizeLanguage(){
        navigationItem.title = "FAVORITE_NAVIGATION".localized()
    }
   
}
