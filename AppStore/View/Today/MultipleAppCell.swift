//
//  MultipleAppCell.swift
//  AppStore
//
//  Created by Xpress Integration on 4/30/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

class MultipleAppCell: UICollectionViewCell {
    let imageView = UIImageView(cornerRadius: 8)
    
    let nameLbl = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 16))
    let companyLbl = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    let getButton = UIButton(title: "GET")
    
    let seperatorView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        return v
    }()
    
    var result: FeedResult! {
        didSet {
            nameLbl.text = result.name
            companyLbl.text = result.artistName
            imageView.sd_setImage(with: URL(string: result.artworkUrl100))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nameLbl.numberOfLines = 2
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        getButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        getButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        getButton.layer.cornerRadius = 32 / 2
        getButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        let lblsStackView = UIStackView(arrangedSubviews: [nameLbl, companyLbl])
        lblsStackView.spacing = 4
        lblsStackView.axis = .vertical
        let stackView = UIStackView(arrangedSubviews: [imageView, lblsStackView, getButton])
        stackView.spacing = 8
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview()
        addSubview(seperatorView)
        seperatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 0.5))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
