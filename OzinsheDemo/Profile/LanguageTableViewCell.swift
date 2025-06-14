//
//  LanguageTableViewCell.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 14.06.2025.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {
    let identifier = "LanguageCell"
    lazy var languageLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        return label
    }()
    
    lazy var checkImage : UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "Check")
        return imageview
    }()
  
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupUI(){
        contentView.addSubview(languageLabel)
        contentView.addSubview(checkImage)
               
       languageLabel.snp.makeConstraints { make in
           make.left.equalToSuperview().offset(24)
           make.centerY.equalToSuperview()
       }
       checkImage.snp.makeConstraints { make in
           make.right.equalToSuperview().inset(24)
           make.centerY.equalToSuperview()
           make.width.height.equalTo(24)
       }
    }
    
    func setChecked(_ isChecked: Bool) {
           checkImage.isHidden = !isChecked
       }

}
