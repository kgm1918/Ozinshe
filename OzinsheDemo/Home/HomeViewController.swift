//
//  HomeViewController.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 03.06.2025.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class HomeViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentStackView = UIStackView()
    var popularMovies: [BannerMovie] = []
    var continueWatchingMovies: [Movie] = []
    var mainMovies : [Movie] = []
    var genresList: [Movie] = []
    var ageList: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "FFFFFF")
        setupScrollView()
        setupContent()
        navigationItem.backButtonTitle = ""
        downloadMainBanners()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    private func setupScrollView() {
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        contentStackView.axis = .vertical
        contentStackView.spacing = 20
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32)
        ])
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }
    
    private func setupContent() {
        contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let logoRow = makeHeader()
        let featuredBanner = makeFavList()
        
        contentStackView.addArrangedSubview(logoRow)
        contentStackView.addArrangedSubview(featuredBanner)
        
        if !continueWatchingMovies.isEmpty {
            let historyCards = continueWatchingMovies.map { movie in
                MovieCardView(item: movie, onTap: { [weak self] in
                    let detailVC = DetailViewController()
                    detailVC.movie = movie
                    self?.navigationController?.pushViewController(detailVC, animated: true)
                })
            }
            let historySection = makeHorizontalSection(title: "Жалғастыру", cards: historyCards, type: 2)
            contentStackView.addArrangedSubview(historySection)
        }
        
        
        let trendingCards = mainMovies.map { movie in
            MovieCardView(item: movie, onTap: {
                let detailVC = DetailViewController()
                detailVC.movie = movie
                self.navigationController?.pushViewController(detailVC, animated: true)
            })
        }
        let trendingSection = makeHorizontalSection(title: "Трендтегілер", cards: trendingCards, type: 3)
        contentStackView.addArrangedSubview(trendingSection)
        
        let forYouCards = mainMovies.map { movie in
            MovieCardView(item: movie, onTap: {
                let detailVC = DetailViewController()
                detailVC.movie = movie
                self.navigationController?.pushViewController(detailVC, animated: true)
            })
        }
        let forYouSection = makeHorizontalSection(title: "Сізге арналған фильмдер", cards: forYouCards, type: 3)
        contentStackView.addArrangedSubview(forYouSection)
        
        let genresCards = genresList.map { movie in
            MovieCardView(item: movie, onTap: {
                
            })
        }
        let genresSection = makeHorizontalSection(title: "Жанрды таңдаңыз", cards: genresCards, type: 4)
        contentStackView.addArrangedSubview(genresSection)
        
        let newProjectCards = mainMovies.map { movie in
            MovieCardView(item: movie, onTap: {
                let detailVC = DetailViewController()
                detailVC.movie = movie
                self.navigationController?.pushViewController(detailVC, animated: true)
            })
        }
        let newProjectsSection = makeHorizontalSection(title: "Жаңа жобалар", cards: newProjectCards, type: 3)
        contentStackView.addArrangedSubview(newProjectsSection)
        
        let tvprogramAndReality = mainMovies.map { movie in
            MovieCardView(item: movie, onTap: {
                let detailVC = DetailViewController()
                detailVC.movie = movie
                self.navigationController?.pushViewController(detailVC, animated: true)
            })
        }
        let tvprogramAndRealitySection = makeHorizontalSection(title: "Тв-бағдарлама және реалити-шоу", cards: tvprogramAndReality, type: 3)
        contentStackView.addArrangedSubview(tvprogramAndRealitySection)
        
        let film = mainMovies.map { movie in
            MovieCardView(item: movie, onTap: {
                let detailVC = DetailViewController()
                detailVC.movie = movie
                self.navigationController?.pushViewController(detailVC, animated: true)
            })
        }
        let filmSection = makeHorizontalSection(title: "Телехикая", cards: film, type: 3)
        contentStackView.addArrangedSubview(filmSection)
        
        let ageCards = ageList.map { movie in
            MovieCardView(item: movie, onTap: {
            })
        }
        let agesSection = makeHorizontalSection(title: "Жасына сәйкес", cards: ageCards, type: 4)
        contentStackView.addArrangedSubview(agesSection)
        
        let documentaryFilms = mainMovies.map { movie in
            MovieCardView(item: movie, onTap: {
                let detailVC = DetailViewController()
                detailVC.movie = movie
                self.navigationController?.pushViewController(detailVC, animated: true)
            })
        }
        let documentarySection = makeHorizontalSection(title: "Деректі фильм", cards: documentaryFilms, type: 3)
        contentStackView.addArrangedSubview(documentarySection)
        
        let foreignFilms = mainMovies.map { movie in
            MovieCardView(item: movie, onTap: {
                let detailVC = DetailViewController()
                detailVC.movie = movie
                self.navigationController?.pushViewController(detailVC, animated: true)
            })
        }
        let foreignFilmsSection = makeHorizontalSection(title: "Шетел фильмдері", cards: foreignFilms, type: 3)
        contentStackView.addArrangedSubview(foreignFilmsSection)
    }
    
    private func makeHeader() -> UIView {
        let container = UIView()
        container.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        let logo = UIImageView()
        logo.image = UIImage(named: "logo-home")
        logo.contentMode = .scaleAspectFit
        logo.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(logo)
        
        NSLayoutConstraint.activate([
            logo.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: -8),
            logo.topAnchor.constraint(equalTo: container.topAnchor, constant: 50),
            logo.heightAnchor.constraint(equalToConstant: 120),
            logo.widthAnchor.constraint(equalToConstant: 160)
        ])
        return container
    }
    
    private func makeFavList() -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(scroll)
        
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: container.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        let cards = popularMovies.map { bannerMovie in
            return MovieCardView(item: bannerMovie, onTap: { [weak self] in
                guard let self = self else { return }
                let detailVC = DetailViewController()
                 detailVC.movie = bannerMovie.movie
                self.navigationController?.pushViewController(detailVC, animated: true)
            })
        }
        
        let stack = UIStackView(arrangedSubviews: cards)
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: scroll.topAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            stack.heightAnchor.constraint(equalTo: scroll.heightAnchor)
        ])
        
        return container
    }
    
    private func makeHorizontalSection(title: String, cards : [UIView], type: Int) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        var height : CGFloat = 0
        
        if type == 2 {
            height = 200
        } else if type == 3{
            height = 265
            let button = UIButton()
            button.setTitle("Барлығы", for: .normal)
            button.setTitleColor(UIColor(named: "B376F7"), for: .normal)
            button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
            button.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(button)
            
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: container.topAnchor),
                button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10)
            ])
        } else {
            height = 146
        }
        
        container.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        let sectionLabel = UILabel()
        sectionLabel.text = title
        sectionLabel.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(sectionLabel)
        
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(scroll)
        
        NSLayoutConstraint.activate([
            sectionLabel.topAnchor.constraint(equalTo: container.topAnchor),
            scroll.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 16),
            scroll.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        
        
        let stack = UIStackView(arrangedSubviews: cards)
        stack.axis = .horizontal
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: scroll.topAnchor),
            stack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            stack.heightAnchor.constraint(equalTo: scroll.heightAnchor)
            
        ])
        
        return container
    }
    
    func downloadMainBanners() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        AF.request(Urls.MAIN_BANNERS_URL, method: .get, headers: headers).responseData { response in
            
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
                    for item in array {
                        let bannerMovie = BannerMovie(json: item)
                        self.popularMovies.append(bannerMovie)
                    }
                    //                    print("popularMovies.count:", self.popularMovies.count)
                    
                    DispatchQueue.main.async {
                        self.setupContent()
                    }
                    
                }
            }
            self.downloadMovieHistory()
        }}
    
    func downloadMovieHistory() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        AF.request(Urls.USER_HISTORY_URL, method: .get, headers: headers).responseData { response in
            
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
                    for item in array {
                        let movie = Movie(json: item)
                        movie.cardType = 2
                        self.continueWatchingMovies.append(movie)
                    }
                    print("continueWatchingMovies.count:", self.continueWatchingMovies.count)
                    
                    DispatchQueue.main.async {
                        self.setupContent()
                    }
                    
                }
            }
            self.downloadMainMovies()
        }}
    
    
    func downloadMainMovies() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        AF.request(Urls.MAIN_MOVIES_URL, method: .get, headers: headers).responseData { response in
            
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
                    for item in array {
                        if let moviesArray = item["movies"].array {
                            for movieJSON in moviesArray {
                                let movie = Movie(json: movieJSON)
                                movie.cardType = 3
                                self.mainMovies.append(movie)
                            }
                        }
                    }
//                print("mainMovies.count:", self.mainMovies.count)
                }
                
                DispatchQueue.main.async {
                    self.setupContent()
                }
                
            }
            self.downloadGenres()
        }
    }
    func downloadGenres(){
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        AF.request(Urls.GET_GENRES, method: .get, headers: headers).responseData { response in
            
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
                    for item in array {
                        let genre = Genre(json: item)
                        let movie = Movie(genre: genre)
                        self.genresList.append(movie)
                        
                    }
//                    print("genresList.count:", self.genresList.count)
                    
                    DispatchQueue.main.async {
                        self.setupContent()
                    }
                    
                }
            }
            self.downloadAges()
        }
        
    }
    func downloadAges(){
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        AF.request(Urls.GET_AGES, method: .get, headers: headers).responseData { response in
            
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
                    for item in array {
                        let age = Age(json: item)
                        let movie = Movie(age: age)
                        self.ageList.append(movie)
                        
                    }
                    print("ageList.count:", self.ageList.count)
                    
                    DispatchQueue.main.async {
                        self.setupContent()
                    }
                    
                }
            }
        }
    }
}
