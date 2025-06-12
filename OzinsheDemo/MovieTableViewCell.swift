//
//  MovieTableViewCell.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 03.06.2025.
//

import UIKit
import SnapKit

class MovieTableViewCell: UITableViewCell {
    let identifier = "MovieTableCell"
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Қызғалдақтар мекені"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827")
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "2020 • Телехикая • Мультфильм"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(named: "9CA3AF")
        return label
    }()
    
    lazy var playView : UIView = {
        let playview = UIView()
        playview.backgroundColor = UIColor(named: "F8EEFF")
        playview.layer.cornerRadius = 8
        let imageView = UIImageView(image: UIImage(named: "Play-Filled"))
        let label = UILabel()
        label.text = "Қарау"
        label.textColor = UIColor(named: "9753F0")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 12)
        playview.addSubview(imageView)
        playview.addSubview(label)
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.verticalEdges.equalToSuperview().inset(5)
            make.size.equalTo(16)
        }
        label.snp.makeConstraints { make in
            make.centerY.equalTo(imageView)
            make.left.equalTo(imageView.snp.right).offset(4)
            make.right.equalToSuperview().inset(12)
        }
        return playview
    }()
    
    lazy var bottomView = {
        let bottomview = UIView()
        bottomview.backgroundColor = UIColor(named: "D1D5DB")
        return bottomview
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI(){
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(playView)
        contentView.addSubview(bottomView)
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.equalToSuperview().inset(24)
            make.height.equalTo(104)
            make.width.equalTo(71)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.equalTo(posterImageView.snp.right).offset(17)
            make.right.equalToSuperview().inset(24)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(posterImageView.snp.right).offset(17)
            make.right.equalToSuperview().inset(24)
        }
        
        playView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(24)
            make.left.equalTo(posterImageView.snp.right).offset(17)
        }
        
        bottomView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.movietitle
        subtitleLabel.text = movie.description
        posterImageView.image = UIImage(named: movie.imageName)
    }


}
