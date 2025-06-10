//
//  DetailViewController.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 08.06.2025.
//

import UIKit

class DetailViewController: UIViewController {
    var movie: Movie?
    var isExpanded = false
    var fadeView: UIView!
    var moreButton : UIButton!
    var scrollView = UIScrollView()
    var contentStackView = UIStackView()
    let popularMovies: [Movie] = [
        Movie(title: "", imageName: "aidar", movietitle: "Айдар", description: "Мультсериал", cardType: 3),
        Movie(title: "", imageName: "samruk", movietitle: "Суперкөлік Самұрық", description: "Мультсериал", cardType: 3),
        Movie(title: "", imageName: "kanikul", movietitle: "Каникулы off-line 2", description: "Телехикая", cardType: 3)
    ]
    let screenshots : [Movie] = [
        Movie(title: "", imageName: "firstscreen", movietitle: "", description: "", cardType: 4),
        Movie(title: "", imageName: "secondscreen", movietitle: "", description: "", cardType: 4)
    ]
    
    lazy var backgroundPicture : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: movie!.imageName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var whiteView : UIView = {
        let whiteview = UIView()
        whiteview.backgroundColor = .white
        whiteview.layer.cornerRadius = 32
        whiteview.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        whiteview.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: whiteview.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: whiteview.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: whiteview.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: whiteview.bottomAnchor)
        ])
        contentStackView.axis = .vertical
        contentStackView.spacing = 20
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        let title = UILabel()
        title.text = movie?.movietitle
        title.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        title.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            title.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24)
        ])
        let briefInfo = UILabel()
        briefInfo.text = "2020 • Телехикая • 5 сезон, 46 серия, 7 мин"
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
        let description = UILabel()
        description.text = "Шытырман оқиғалы мультсериал Елбасының «Ұлы даланың жеті қыры» бағдарламасы аясында жүзеге асырылған. Мақалада қызғалдақтардың отаны Қазақстан екені айтылады. Ал, жоба қызғалдақтардың отаны – Алатау баурайы екенін анимация тілінде дәлелдей түседі."
        description.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        description.textColor = UIColor(named: "9CA3AF")
        description.numberOfLines = 0
        description.translatesAutoresizingMaskIntoConstraints = false
        descriptionContainer.addSubview(description)
        
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
            
            description.topAnchor.constraint(equalTo: descriptionContainer.topAnchor),
            description.leadingAnchor.constraint(equalTo: descriptionContainer.leadingAnchor),
            description.trailingAnchor.constraint(equalTo: descriptionContainer.trailingAnchor),
            description.bottomAnchor.constraint(equalTo: descriptionContainer.bottomAnchor),
            
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
        let directorLabel = UILabel()
        directorLabel.text = "Режиссер:"
        directorLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        directorLabel.textColor = UIColor(named: "4B5563")
        directorLabel.translatesAutoresizingMaskIntoConstraints = false
        let directorName = UILabel()
        directorName.text = "Бақдәулет Әлімбеков"
        directorName.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        directorName.textColor = UIColor(named: "9CA3AF")
        directorName.translatesAutoresizingMaskIntoConstraints = false
        let producerLabel = UILabel()
        producerLabel.text = "Продюсер:"
        producerLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        producerLabel.textColor = UIColor(named: "4B5563")
        producerLabel.translatesAutoresizingMaskIntoConstraints = false
        let producerName = UILabel()
        producerName.text = "Сандуғаш Кенжебаева"
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
        let firstSectionCards = screenshots.map {
            makeCard(from: $0)
        }
        let firstSection = makeHorizontalSection(title: "Скриншоттар", cards: firstSectionCards, type: 4)
        contentStackView.addArrangedSubview(firstSection)
        let secondSectionCards = popularMovies.map {
            makeCard(from: $0)
        }
        let secondSection = makeHorizontalSection(title: "Ұқсас телехикаялар", cards: secondSectionCards, type: 3)
        contentStackView.addArrangedSubview(secondSection)
        NSLayoutConstraint.activate([
            seriesSection.topAnchor.constraint(equalTo: secondSeparatorView.bottomAnchor, constant: 32),
        ])
        return whiteview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationItem.backButtonTitle = ""
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
        let add = makeIconWithLabel(imageName: "Bookmark", text: "Тізімге қосу")
        let share = makeIconWithLabel(imageName: "Share", text: "Бөлісу")
        view.addSubview(add)
        view.addSubview(share)
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: backgroundPicture.topAnchor, constant: 200),
            playButton.centerXAnchor.constraint(equalTo: backgroundPicture.centerXAnchor),
            
            add.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            add.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -20),

            share.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            share.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 23)
        ])
        
        view.addSubview(whiteView)
        NSLayoutConstraint.activate([
            whiteView.topAnchor.constraint(equalTo: view.topAnchor, constant: 320),
            whiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            whiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
       
    }
    
    private func makeCard(from movie: Movie) -> UIView {
        return MovieCardView(movie: movie) { [weak self] in
               guard let self = self else { return }
               let detailVC = DetailViewController()
               detailVC.movie = movie
               self.navigationController?.pushViewController(detailVC, animated: true)
          
           }
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
            return container
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

        return container
    }
    
    func makeSeriesSection()-> UIStackView{
        let sectionsTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "Бөлімдер"
            label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
            label.textColor = .label
            return label
        }()

        let seasonLabel: UILabel = {
            let label = UILabel()
            label.text = "5 сезон, 46 серия"
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
        topStackView.addArrangedSubview(sectionsTitleLabel)
        
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
        gradient.colors = [
            UIColor.white.withAlphaComponent(1.0).cgColor,
            UIColor.white.withAlphaComponent(0.0).cgColor
        ]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.frame = fadeView.bounds
        
        fadeView.layer.addSublayer(gradient)
    }
    
    
    func makeIconWithLabel(imageName: String, text: String) -> UIStackView {
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "D1D5DB")
        label.textAlignment = .center
        
        let stack = UIStackView(arrangedSubviews: [imageView, label])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    @objc func moreButtonTapped(){
        isExpanded.toggle()
        fadeView.isHidden = isExpanded
        if isExpanded {
            moreButton.setTitle("Жасыру", for: .normal)
        } else {
            moreButton.setTitle("Толығырақ", for: .normal)
        }
    }
    
    @objc func playButtonTapped(){
        print("check")
        let episodesVC = EpisodesTableViewController()
        self.navigationController?.pushViewController(episodesVC, animated: true)
    }
    
}
