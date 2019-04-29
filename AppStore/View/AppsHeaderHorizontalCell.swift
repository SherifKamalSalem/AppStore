//
//  AppsHeaderHorizontalCell.swift
//  AppStore
//
//  Created by Xpress Integration on 4/26/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalCell: UICollectionViewCell {
    
    var socialMediaApp: SocialApp! {
        didSet {
            companyLbl.text = socialMediaApp.name
            titleLbl.text = socialMediaApp.tagline
            imageView.sd_setImage(with: URL(string: socialMediaApp.imageUrl))
        }
    }
    
    let companyLbl = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 12))
    let titleLbl = UILabel(text: "Keeping up with friends faster than ever", font: .systemFont(ofSize: 24))
    let imageView = UIImageView(cornerRadius: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLbl.numberOfLines = 2
        let stackView = UIStackView(arrangedSubviews: [companyLbl, titleLbl, imageView])
        stackView.axis = .vertical
        stackView.spacing = 12
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
