//
//  SeasonsCollectionViewCell.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 05.07.2025.
//

import UIKit
import SnapKit

class SeasonsCollectionViewCell: UICollectionViewCell {
        
        let identifier = "SeasonCell"
        
        let backView = {
            let view = UIView()
            view.backgroundColor = UIColor(named: "9753F0")
            view.layer.cornerRadius = 8
            return view
        }()
        
        let seasonLabel = {
            let label = UILabel()
            label.text = "1 сезон"
            label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
            label.textColor = .white
            label.textAlignment = .center
            
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupUI()
            backgroundColor = .white
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setupUI() {
            
            contentView.addSubview(backView)
            contentView.addSubview(seasonLabel)
            
            backView.snp.makeConstraints { make in
                make.top.right.bottom.left.equalToSuperview()
            }
            
            seasonLabel.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(16)
                make.top.bottom.equalToSuperview()
            }
        }
}
