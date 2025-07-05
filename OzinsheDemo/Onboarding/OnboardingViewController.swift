//
//  FirstOnboardingViewController.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 03.06.2025.
//

import UIKit

class OnboardingViewController: UIViewController {
    lazy var backgroundImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var welcomeImageView : UIImageView = {
        let titleImage = UIImageView()
        titleImage.contentMode = .scaleAspectFit
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        return titleImage
    }()
    
    lazy var informationText: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        text.textColor = UIColor(named: "6B7280")
        text.numberOfLines = 0
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    
    init(backgroundImage: String, welcomeImage: String, information: String){
        super.init(nibName: nil, bundle: nil)
        self.backgroundImageView.image = UIImage(named: backgroundImage)
        self.welcomeImageView.image = UIImage(named: welcomeImage)
        self.informationText.text = information
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "FFFFFF")
        view.addSubview(backgroundImageView)
        view.addSubview(welcomeImageView)
        view.addSubview(informationText)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 504),
            
            welcomeImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 473),
            welcomeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            welcomeImageView.widthAnchor.constraint(equalToConstant: 295),
            
            informationText.topAnchor.constraint(equalTo: welcomeImageView.bottomAnchor, constant: 24),
            informationText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            informationText.widthAnchor.constraint(equalToConstant: 311)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyGradientMask(to: backgroundImageView)
    }

    func applyGradientMask(to imageView: UIImageView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = imageView.bounds
        gradientLayer.colors = [
            UIColor.black.cgColor,
            UIColor.clear.cgColor
        ]
        gradientLayer.locations = [0.6, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        imageView.layer.mask = gradientLayer
    }


}
