//
//  MovieCardView.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 08.06.2025.
//

import Foundation
import UIKit

class MovieCardView: UIView {

    var onTap: (() -> Void)?

    init(movie: Movie, onTap: (() -> Void)? = nil) {
        super.init(frame: .zero)
        self.onTap = onTap
        setupView(with: movie)
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }

    @objc private func handleTap() {
        onTap?()
    }

    private func setupView(with movie: Movie) {
        translatesAutoresizingMaskIntoConstraints = false
        let imageView = UIImageView(image: UIImage(named: movie.imageName))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)

        var width: CGFloat = 300
        var height: CGFloat = 165
        var titleFontSize: CGFloat = 14
        var showTitle = true

        switch movie.cardType {
        case 1:
            let tagLabel = UILabel()
            tagLabel.text = movie.title
            tagLabel.textColor = .white
            tagLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
            tagLabel.backgroundColor = UIColor(named: "7E2DFC")
            tagLabel.textAlignment = .center
            tagLabel.layer.cornerRadius = 8
            tagLabel.clipsToBounds = true
            tagLabel.translatesAutoresizingMaskIntoConstraints = false
            imageView.addSubview(tagLabel)

            NSLayoutConstraint.activate([
                tagLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
                tagLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
                tagLabel.heightAnchor.constraint(equalToConstant: 24),
                tagLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 77)
            ])

        case 2:
            width = 184
            height = 112
            titleFontSize = 12

        case 3:
            width = 112
            height = 164
            titleFontSize = 12

        case 4:
            width = 184
            height = 112
            showTitle = false
            let label = UILabel()
            label.text = movie.title
            label.textColor = .white
            label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            imageView.addSubview(label)

            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
            ])

        default: break
        }

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: width),
            imageView.heightAnchor.constraint(equalToConstant: height)
        ])

        if showTitle {
            let titleLabel = UILabel()
            titleLabel.text = movie.movietitle
            titleLabel.numberOfLines = 2
            titleLabel.font = UIFont(name: "SFProDisplay-Bold", size: titleFontSize)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false

            let descLabel = UILabel()
            descLabel.text = movie.description
            descLabel.font = UIFont(name: "SFProDisplay-Regular", size: 12)
            descLabel.textColor = UIColor(named: "9CA3AF")
            descLabel.numberOfLines = 2
            descLabel.translatesAutoresizingMaskIntoConstraints = false

            addSubview(titleLabel)
            addSubview(descLabel)

            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                titleLabel.widthAnchor.constraint(equalToConstant: width),

                descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                descLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                descLabel.widthAnchor.constraint(equalToConstant: width),
                descLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            
            NSLayoutConstraint.activate([
                self.widthAnchor.constraint(equalToConstant: width),
                self.heightAnchor.constraint(equalToConstant: showTitle ? (height + 60) : height)
            ])

        }
    }
}
