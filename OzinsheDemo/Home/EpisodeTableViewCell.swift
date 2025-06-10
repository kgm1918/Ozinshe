//
//  EpisodeTableViewCell.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 10.06.2025.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
    var labeltext = ""
    lazy var episodeScreen : UIImageView = {
        let imageview = UIImageView()
        imageview.backgroundColor = UIColor(named: "374151")
        imageview.layer.cornerRadius = 8
        return imageview
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827")
        return label
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
        contentView.addSubview(episodeScreen)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bottomView)
        
        episodeScreen.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(179)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(episodeScreen.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
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

    func configure(title: String, image: UIImage?) {
        titleLabel.text = title
        episodeScreen.image = image
    }

}
