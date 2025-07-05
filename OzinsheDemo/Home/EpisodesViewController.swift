//
//  EpisodesViewController.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 10.06.2025.
//

import UIKit
import SwiftyJSON
import SVProgressHUD
import Alamofire

class EpisodesController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    var movie = Movie()
    var seasons : [Season] = []
    var currentSeason = 0

    var episodes : [Episode] = []
    
    lazy var episodesTableView : UITableView = {
        let tableview = UITableView()
        tableview.separatorStyle = .none
        tableview.register(EpisodeTableViewCell.self, forCellReuseIdentifier: "EpisodeCell")
        tableview.backgroundColor = UIColor(named: "FFFFFF")
        return tableview
    }()
    
    lazy var seriesCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        layout.itemSize = CGSize(width: 78, height: 34)
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.backgroundColor = UIColor(named: "FFFFFF")
        collectionview.register(SeasonsCollectionViewCell.self, forCellWithReuseIdentifier: "SeasonCell")
        collectionview.showsHorizontalScrollIndicator = false
        return collectionview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "FFFFFF")
        navigationController?.navigationBar.tintColor = UIColor(named: "blackcolor")
        navigationItem.title = "Бөлімдер"
        
        seriesCollectionView.delegate = self
        seriesCollectionView.dataSource = self
        view.addSubview(seriesCollectionView)
        seriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            seriesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            seriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            seriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            seriesCollectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
        view.addSubview(episodesTableView)
        episodesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            episodesTableView.topAnchor.constraint(equalTo: seriesCollectionView.bottomAnchor, constant: 10),
            episodesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            episodesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            episodesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
       ])
        downloadSeasons()
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return episodes.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath) as! EpisodeTableViewCell
        let episode = episodes[indexPath.row]
        let urlImage = "https://img.youtube.com/vi/\(episode.link)/hqdefault.jpg"
        cell.configure(episodeNumber: episode.number, imageLink: urlImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playerVC = PlayerViewController()
        playerVC.video_link = seasons[currentSeason].videos[indexPath.row].link
        navigationController?.show(playerVC, sender: self)
        navigationItem.title = ""
        self.title = "Бөлімдер"
    }

   // MARK: collectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seasons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeasonCell", for: indexPath) as! SeasonsCollectionViewCell
              
          cell.seasonLabel.text = "\(seasons[indexPath.row].number) сезон"
          
          cell.backView.layer.cornerRadius = 8
          if currentSeason == seasons[indexPath.row].number - 1 {
              cell.seasonLabel.textColor = UIColor(displayP3Red: 249/255, green: 250/255, blue: 251/255, alpha: 1)
              cell.backView.backgroundColor = UIColor(displayP3Red: 151/255, green: 83/255, blue: 240/255, alpha: 1)
          } else {
              cell.seasonLabel.textColor = UIColor(displayP3Red: 55/255, green: 65/255, blue: 81/255, alpha: 1)
              cell.backView.backgroundColor = UIColor(displayP3Red: 243/255, green: 244/255, blue: 246/255, alpha: 1)
          }
          return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentSeason = indexPath.row
        seriesCollectionView.reloadData()

        let selectedSeason = seasons[indexPath.row]
        downloadEpisodes(for: selectedSeason)

    }
     func downloadSeasons(){
         SVProgressHUD.show()
         let headers: HTTPHeaders = [
             "Authorization" : "Bearer \(Storage.sharedInstance.accessToken)"]
         let url = Urls.GET_SEASONS + "\(movie.id)"
         print("THIS URL", url)
         AF.request(url, method: .get, headers: headers).responseData { response in
             SVProgressHUD.dismiss()
             var resultString = ""
             if let data = response.data {
                 resultString = String(data: data, encoding: .utf8)!
             }
             if response.response?.statusCode == 200 {
                 let json = JSON(response.data!)
                 print(json)
                 if let array = json.array {
                     for item in array {
                         let season = Season(json: item)
                         self.seasons.append(season)
                     }
                     self.seriesCollectionView.reloadData()
                     if let firstSeason = self.seasons.first {
                         self.downloadEpisodes(for: firstSeason)
                     }

                 }
                 else {
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
    
    func downloadEpisodes(for season: Season) {
        episodes.removeAll()
        episodes = season.videos
        episodesTableView.reloadData()
    }


    
}
