//
//  HomeViewController.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 03.06.2025.
//

import UIKit

class HomeViewController: UIViewController {

        let scrollView = UIScrollView()
        let contentStackView = UIStackView()
        let popularMovies: [Movie] = [
            Movie(title: "", imageName: "aidar", movietitle: "Айдар", description: "Мультсериал", cardType: 3),
            Movie(title: "", imageName: "samruk", movietitle: "Суперкөлік Самұрық", description: "Мультсериал", cardType: 3),
            Movie(title: "", imageName: "kanikul", movietitle: "Каникулы off-line 2", description: "Телехикая", cardType: 3)
        ]
        let continueWatchingMovies: [Movie] = [
            Movie(title: "", imageName: "globus",movietitle: "Глобус", description: "2-бөлім", cardType: 2),
            Movie(title: "", imageName: "tabigat",movietitle: "Табиғат сақшылары", description: "4-бөлім", cardType: 2)
        ]
    
        let genresList: [Movie] = [
            Movie(title: "Мультфильм", imageName: "firstgenre", movietitle: "", description: "", cardType: 4),
            Movie(title: "Телехикая", imageName: "secondgenre", movietitle: "", description: "", cardType: 4),
            Movie(title: "Көркем фильм", imageName: "thirdgenre", movietitle: "", description: "", cardType: 4)
        ]
    
        let ageList: [Movie] = [
            Movie(title: "8-10 жас", imageName: "bg", movietitle: "", description: "", cardType: 4),
            Movie(title: "10-12 жас", imageName: "bg-2", movietitle: "", description: "", cardType: 4),
        ]

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            setupScrollView()
            setupContent()
            navigationItem.backButtonTitle = ""
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
                contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32)
            ])
        }

        private func setupContent() {
            let logoRow = makeHeader()
            let featuredBanner = makeFavList()
            let section1Cards = continueWatchingMovies.map { makeCard(from: $0) }
            let section1 = makeHorizontalSection(title: "Қарауды жалғастырыңыз", cards: section1Cards, type: 2)
            let section2Cards = popularMovies.map {
                makeCard(from: $0)
            }
            let section2 = makeHorizontalSection(title: "Трендтегілер", cards: section2Cards, type: 3)

            let section3Cards = popularMovies.map {
                makeCard(from: $0)
            }
            let section3 = makeHorizontalSection(title: "Сізге арналған фильмдер", cards: section3Cards, type: 3)

            let section4Cards = genresList.map {
                makeCard(from: $0)
            }
            let section4 = makeHorizontalSection(title: "Жанрды таңдаңыз", cards: section4Cards, type: 4)
            
            let section5Cards = popularMovies.map {
                makeCard(from: $0)
            }
            let section5 = makeHorizontalSection(title: "Жаңа жобалар", cards: section5Cards, type: 3)
            
            let section6Cards = popularMovies.map {
                makeCard(from: $0)            }
            let section6 = makeHorizontalSection(title: "Тв-бағдарлама және реалити-шоу", cards: section6Cards, type: 3)
            
            let section7Cards = popularMovies.map {
                makeCard(from: $0)
            }
            let section7 = makeHorizontalSection(title: "Телехикая", cards: section7Cards, type: 3)
            
            let section8Cards = ageList.map {
                makeCard(from: $0)
            }
            let section8 = makeHorizontalSection(title: "Жасына сәйкес", cards: section8Cards, type: 4)
            
            let section9Cards = popularMovies.map {
                makeCard(from: $0)
            }
            let section9 = makeHorizontalSection(title: "Деректі фильм", cards: section9Cards, type: 3)
            
            let section10Cards = popularMovies.map {
                makeCard(from: $0)
            }
            let section10 = makeHorizontalSection(title: "Шетел фильмдері", cards: section10Cards, type: 3)
            
            contentStackView.addArrangedSubview(logoRow)
            contentStackView.addArrangedSubview(featuredBanner)
            contentStackView.addArrangedSubview(section1)
            contentStackView.addArrangedSubview(section2)
            contentStackView.addArrangedSubview(section3)
            contentStackView.addArrangedSubview(section4)
            contentStackView.addArrangedSubview(section5)
            contentStackView.addArrangedSubview(section6)
            contentStackView.addArrangedSubview(section7)
            contentStackView.addArrangedSubview(section8)
            contentStackView.addArrangedSubview(section9)
            contentStackView.addArrangedSubview(section10)
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

    private func makeCard(from movie: Movie) -> UIView {
        return MovieCardView(movie: movie) { [weak self] in
               guard let self = self else { return }
               let detailVC = DetailViewController()
               detailVC.movie = movie
               self.navigationController?.pushViewController(detailVC, animated: true)
          
           }
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
      
        let card1 = makeCard(from: Movie(title: "Телехикая", imageName: "kizgaldaktar", movietitle: "Қызғалдақтар мекені", description: "Шытырман оқиғалы мультсериал Елбасының «Ұлы даланың жеті қыры» бағдарламасы аясында жүз...", cardType: 1))
        let card2 = makeCard(from: Movie(title: "Телехикая", imageName: "kizgaldaktar", movietitle: "Ойыншықтар", description: "5 жасар Алуаның ойыншықтары өте көп. Ол барлығын бірдей жақсы көріп, ұқыпты, таза ұстайды", cardType: 1))

        
        let stack = UIStackView(arrangedSubviews: [card1, card2])
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

}


