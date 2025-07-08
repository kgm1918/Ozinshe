//
//  DetailViewController.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 08.06.2025.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
import Alamofire

class DetailViewController: UIViewController {
    var descriptionLabel: UILabel!
    var descriptionContainer: UIView!
    var addButton : UIButton!
    var shareButton : UIButton!
    var firstSection : UIView!
    var secondSection: UIView!
    var seriesTitleLabel : UILabel!
    var firstSectionTitleLabel : UILabel!
    var secondSectionTitleLabel: UILabel!
    var directorLabel: UILabel!
    var producerLabel: UILabel!
    var movie: Movie?
    var isExpanded = false
    var fadeView: UIView!
    var moreButton : UIButton!
    var scrollView = UIScrollView()
    var contentStackView = UIStackView()
    var similarMovies: [Movie] = []
    var screenshots : [Screenshot] = []
    
    lazy var backgroundPicture : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
//        imageView.image = UIImage(named: movie!.imageName)
        if let url = URL(string: movie!.imageName) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        imageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var whiteView : UIView = {
        let whiteview = UIView()
        whiteview.backgroundColor = UIColor(named: "FFFFFF")
        whiteview.layer.cornerRadius = 32
        whiteview.translatesAutoresizingMaskIntoConstraints = false
        whiteview.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: whiteview.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: whiteview.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: whiteview.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: whiteview.safeAreaLayoutGuide.bottomAnchor)

        ])
        contentStackView.axis = .vertical
        contentStackView.spacing = 20
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        let title = UILabel()
        title.text = movie?.movieTitle
        title.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        title.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            title.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24)
        ])
        let briefInfo = UILabel()
        let year = String(movie!.year)
        let movieType = movie!.categories.first?.name ?? ""
        let seasonCount = String(movie!.seasonCount)
        let seriesCount = String(movie!.seriesCount)
        let time = String(movie!.timing)

        briefInfo.text = "\(year) • \(movieType) • \(seasonCount) сезон, \(seriesCount) серия, \(time) мин"

        briefInfo.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        briefInfo.textColor = UIColor(named: "9CA3AF")
        briefInfo.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(briefInfo)
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(named: "D1D5DB")
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(separatorView)
        
        let descriptionContainer = UIView()
        descriptionContainer.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(descriptionContainer)
        descriptionLabel = UILabel()
//        description.text = "Шытырман оқиғалы мультсериал Елбасының «Ұлы даланың жеті қыры» бағдарламасы аясында жүзеге асырылған. Мақалада қызғалдақтардың отаны Қазақстан екені айтылады. Ал, жоба қызғалдақтардың отаны – Алатау баурайы екенін анимация тілінде дәлелдей түседі."
        descriptionLabel.text = movie?.desc
        descriptionLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        descriptionLabel.textColor = UIColor(named: "9CA3AF")
        descriptionLabel.numberOfLines = 3
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionContainer.addSubview(descriptionLabel)
        
        fadeView = UIView()
        fadeView.translatesAutoresizingMaskIntoConstraints = false
        fadeView.isUserInteractionEnabled = false
        descriptionContainer.addSubview(fadeView)
        contentStackView.addArrangedSubview(descriptionContainer)
        NSLayoutConstraint.activate([
            briefInfo.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            briefInfo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            separatorView.topAnchor.constraint(equalTo: briefInfo.bottomAnchor, constant: 24),
            separatorView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            separatorView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            descriptionContainer.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 24),
            descriptionContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            descriptionContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionContainer.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionContainer.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionContainer.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionContainer.bottomAnchor),
            
            fadeView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: -40),
            fadeView.leadingAnchor.constraint(equalTo: descriptionContainer.leadingAnchor),
            fadeView.trailingAnchor.constraint(equalTo: descriptionContainer.trailingAnchor),
            fadeView.bottomAnchor.constraint(equalTo: descriptionContainer.bottomAnchor),
            fadeView.heightAnchor.constraint(equalToConstant: 80)
        ])
        moreButton = UIButton()
        moreButton.setTitle("Толығырақ", for: .normal)
        moreButton.setTitleColor(UIColor(named: "B376F7"), for: .normal)
        moreButton.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        moreButton.contentHorizontalAlignment = .leading
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(moreButton)
        directorLabel = UILabel()
        directorLabel.text = "Режиссер:"
        directorLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        directorLabel.textColor = UIColor(named: "4B5563")
        directorLabel.translatesAutoresizingMaskIntoConstraints = false
        let directorName = UILabel()
//        directorName.text = "Бақдәулет Әлімбеков"
        directorName.text = movie?.director
        directorName.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        directorName.textColor = UIColor(named: "9CA3AF")
        directorName.translatesAutoresizingMaskIntoConstraints = false
        producerLabel = UILabel()
        producerLabel.text = "Продюсер:"
        producerLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        producerLabel.textColor = UIColor(named: "4B5563")
        producerLabel.translatesAutoresizingMaskIntoConstraints = false
        let producerName = UILabel()
//        producerName.text = "Сандуғаш Кенжебаева"
        producerName.text = movie?.producer
        producerName.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        producerName.textColor = UIColor(named: "9CA3AF")
        producerName.translatesAutoresizingMaskIntoConstraints = false
        let directorStack = UIStackView(arrangedSubviews: [directorLabel, directorName])
        directorStack.axis = .horizontal
        directorStack.spacing = 8
        directorStack.alignment = .center
        directorStack.translatesAutoresizingMaskIntoConstraints = false
        
        let producerStack = UIStackView(arrangedSubviews: [producerLabel, producerName])
        producerStack.axis = .horizontal
        producerStack.spacing = 8
        producerStack.alignment = .center
        producerStack.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(directorStack)
        contentStackView.addArrangedSubview(producerStack)
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        let secondSeparatorView = UIView()
        secondSeparatorView.backgroundColor = UIColor(named: "D1D5DB")
        secondSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(secondSeparatorView)
        NSLayoutConstraint.activate([
            secondSeparatorView.topAnchor.constraint(equalTo: producerLabel.bottomAnchor, constant: 24),
            secondSeparatorView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            secondSeparatorView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            secondSeparatorView.heightAnchor.constraint(equalToConstant: 1),
        ])
        let seriesSection = makeSeriesSection()
        contentStackView.addArrangedSubview(seriesSection)
        let firstSectionCards = screenshots.map { screenshot in
            let someMovie = Movie()
            someMovie.poster_link = screenshot.link
            someMovie.cardType = 4
            return MovieCardView(item: someMovie, onTap: {})
        }
        let (firstSectionView, firstSectionLabel) = makeHorizontalSection(title: "Скриншоттар", cards: firstSectionCards, type: 4)
        firstSection = firstSectionView
        self.firstSectionTitleLabel = firstSectionLabel
        contentStackView.addArrangedSubview(firstSectionView)
        let secondSectionCards = similarMovies.map { movie in
            MovieCardView(item: movie, onTap: {
            })
        }
        let (secondSectionView, secondSectionLabel) = makeHorizontalSection(title: "Ұқсас телехикаялар", cards: secondSectionCards, type: 3)
        secondSection = secondSectionView
        self.secondSectionTitleLabel = secondSectionLabel
        contentStackView.addArrangedSubview(secondSectionView)
        NSLayoutConstraint.activate([
            seriesSection.topAnchor.constraint(equalTo: secondSeparatorView.bottomAnchor, constant: 32),
        ])
        return whiteview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "FFFFFF")
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backButtonTitle = ""
        screenshots = movie?.screenshots ?? []
        print("Screenshots count: \(screenshots.count)")
        view.addSubview(backgroundPicture)
        NSLayoutConstraint.activate([
            backgroundPicture.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundPicture.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundPicture.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundPicture.heightAnchor.constraint(equalToConstant: 350)
        ])
        let playButton = UIButton()
        playButton.setImage(UIImage(named: "play"), for: .normal)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playButton)
        
        addButton = makeVerticalButton(imageName: "Bookmark", text: "Тізімге қосу", selector: #selector(addToFavorite))
        shareButton = makeVerticalButton(imageName: "Share", text: "Бөлісу", selector: #selector(shareTapped))

        view.addSubview(addButton)
        view.addSubview(shareButton)

        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: backgroundPicture.topAnchor, constant: 200),
            playButton.centerXAnchor.constraint(equalTo: backgroundPicture.centerXAnchor),
                     
            addButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -20),

            shareButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            shareButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 23)
        ])

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(whiteView)
        NSLayoutConstraint.activate([
            whiteView.topAnchor.constraint(equalTo: view.topAnchor, constant: 320),
            whiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            whiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        downloadSimilarMovies()
        print("Screenshots count: \(screenshots.count)")
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChangeNotification), name: NSNotification.Name("LanguageChanged"), object: nil)
        localizeLanguage()
    }
    

    private func makeHorizontalSection(title: String, cards : [UIView], type: Int) -> (UIView, UILabel) {
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
        if type == 1 {
            let button = UIButton()
            button.setTitle("5 сезон 46 серия", for: .normal)
            button.setTitleColor(UIColor(named: "9CA3AF"), for: .normal)
            button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
            button.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(button)
            
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: container.topAnchor),
                button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10)
            ])
            return (container, sectionLabel)
        }
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

        return (container, sectionLabel)
    }
    
    func makeSeriesSection()-> UIStackView {
        seriesTitleLabel = {
            let label = UILabel()
            label.text = "Бөлімдер"
            label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
            label.textColor = .label
            return label
        }()

        let seasonLabel: UILabel = {
            let label = UILabel()
//            label.text = "5 сезон, 46 серия"
            label.text = "\(movie?.seasonCount ?? 0) сезон, \(movie?.seriesCount ?? 0) серия"
            label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
            label.textColor = UIColor(named: "9CA3AF")
            return label
        }()

        let arrowImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "Chevron-Right"))
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()

        let topStackView = UIStackView()
        topStackView.axis = .horizontal
        topStackView.alignment = .center
        topStackView.distribution = .equalSpacing

        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.addArrangedSubview(seriesTitleLabel)
        
        let rightStack = UIStackView(arrangedSubviews: [seasonLabel, arrowImageView])
        rightStack.axis = .horizontal
        rightStack.spacing = 4
        rightStack.alignment = .center
        topStackView.addArrangedSubview(rightStack)
        return topStackView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        fadeView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        let gradient = CAGradientLayer()
        let gradientColor = UIColor(named: "FFFFFF")
        gradient.colors = [
            gradientColor!.withAlphaComponent(1.0).cgColor,
            gradientColor!.withAlphaComponent(0.0).cgColor
        ]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.frame = fadeView.bounds
        
        fadeView.layer.addSublayer(gradient)
    }
    
    
    func makeVerticalButton(imageName: String, text: String, selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.setTitleColor(UIColor(named: "D1D5DB"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        button.setImage(UIImage(named: imageName), for: .normal)
        
        button.tintColor = UIColor(named: "D1D5DB")
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.titleLabel?.textAlignment = .center
        button.contentHorizontalAlignment = .center
        
        let spacing: CGFloat = 4
        button.titleEdgeInsets = UIEdgeInsets(top: spacing, left: -24, bottom: -24, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: -12, left: 0, bottom: 12, right: -button.titleLabel!.intrinsicContentSize.width)

        button.addTarget(self, action: selector, for: .touchUpInside)
        
        return button
    }

    
    @objc func moreButtonTapped() {
        isExpanded.toggle()
        fadeView.isHidden = isExpanded
        descriptionLabel.numberOfLines = isExpanded ? 0 : 3
        moreButton.setTitle(isExpanded ? "Жасыру" : "Толығырақ", for: .normal)

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func playButtonTapped(){
        let episodesVC = EpisodesController()
        episodesVC.movie = movie!
        self.navigationController?.pushViewController(episodesVC, animated: true)
    }
    
    func downloadSimilarMovies() {
        SVProgressHUD.show()
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        let url = "\(Urls.GET_SIMILAR)\(movie?.id ?? 0)"
        print("URL:", url)

        AF.request(url, method: .get, headers: headers).responseData { response in
            
            SVProgressHUD.dismiss()
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
//                print("checkTHIS", resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
//                print("this", json)
                if let array = json.array {
                    for item in array {
                            let movie = Movie(json: item)
                            self.similarMovies.append(movie)
                        }
                    }
//                print("similarMovies.count:", self.similarMovies.count)
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
    
    @objc func addToFavorite() {
           var method = HTTPMethod.post
            if movie!.favorite {
               method = .delete
           }
           
           SVProgressHUD.show()
           
           let headers: HTTPHeaders = [
               "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
           ]
           
            let parameters = ["movieId": movie?.id] as [String : Any]
           
           AF.request(Urls.FAVORITE_URL, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
               
               SVProgressHUD.dismiss()
               var resultString = ""
               if let data = response.data {
                   resultString = String(data: data, encoding: .utf8)!
                   print(resultString)
                            }
                
                if response.response?.statusCode == 200 || response.response?.statusCode == 201 {

                    self.movie!.favorite.toggle()
                    NotificationCenter.default.post(name: NSNotification.Name("FavoritesUpdated"), object: nil)
                    
                }
            }
        }
    @objc func shareTapped(){
            let text = "\(movie!.name) \n\(movie!.desc)"
           let image = backgroundPicture.image
           let shareAll = [text, image!] as [Any]
           let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
           activityViewController.popoverPresentationController?.sourceView = self.view
           self.present(activityViewController, animated: true, completion: nil)
    }
    
    func localizeLanguage(){
        let moreTitle = isExpanded ? "HIDE_DESCRIPTION_BUTTON".localized() : "FULL_DESCRIPTION_BUTTON".localized()
        moreButton.setTitle(moreTitle, for: .normal)
        addButton.setTitle("ADD_TO_FAVORITE".localized(), for: .normal)
        shareButton.setTitle("SHARE_LABEL".localized(), for: .normal)
        firstSectionTitleLabel.text = "SCREENSHOT_LABEL".localized()
        secondSectionTitleLabel.text = "SIMILAR_MOVIES_LABEL".localized()
        seriesTitleLabel.text = "SERIES_LABEL".localized()
        directorLabel.text = "DIRECTOR_LABEL".localized()
        producerLabel.text = "PRODUCER_LABEL".localized()
    }
    
    @objc func languageDidChangeNotification() {
        localizeLanguage()
    }
}
