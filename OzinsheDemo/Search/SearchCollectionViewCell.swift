//
//  SearchCollectionViewCell.swift
//  OzinsheDemo
//
//  Created by Gulnaz Kaztayeva on 11.06.2025.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    let identifier = "SearchCollectionViewCell"
    let backView : UIView = {
        let backview = UIView()
        backview.backgroundColor = UIColor(named: "F3F4F6")
        backview.layer.cornerRadius = 8
        return backview
    }()
    let label : UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "374151")
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        layer.cornerRadius = 8
    }
    func setupUI() {
        contentView.addSubview(backView)
        backView.addSubview(label)
        backView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        label.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(16)
            make.bottom.top.equalToSuperview()
            make.height.equalTo(34)
        }
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
