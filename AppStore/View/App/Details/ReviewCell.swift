//
//  ReviewCell.swift
//  AppStore
//
//  Created by Xpress Integration on 4/29/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
        
    let titleLbl = UILabel(text: "title", font: .boldSystemFont(ofSize: 18))
    let autherLbl = UILabel(text: "auther", font: .systemFont(ofSize: 16))
    let bodyLbl = UILabel(text: "Body", font: .systemFont(ofSize: 18), numberOfLines: 5)
    
    let starsStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        (0..<5).forEach({ (_) in
            let imgView = UIImageView(image: #imageLiteral(resourceName: "star"))
            imgView.widthAnchor.constraint(equalToConstant: 24).isActive = true
            imgView.heightAnchor.constraint(equalToConstant: 24).isActive = true
            arrangedSubviews.append(imgView)
        })
        arrangedSubviews.append(UIView())
        let sv = UIStackView(arrangedSubviews: arrangedSubviews)
        return sv
    }()
    
    var entry: Entry? {
        didSet {
            titleLbl.text = entry?.title.label
            autherLbl.text = entry?.author.name.label
            bodyLbl.text = entry?.content.label
            for (index, view) in starsStackView.arrangedSubviews.enumerated() {
                if let ratingInt = Int(entry!.rating.label) {
                    view.alpha = index >= ratingInt ? 0 : 1
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        autherLbl.textColor = .lightGray
        layer.cornerRadius = 16
        clipsToBounds = true
        let stackView = UIStackView(arrangedSubviews: [UIStackView(arrangedSubviews: [titleLbl, autherLbl], customSpacing: 8) , starsStackView, bodyLbl])
        stackView.spacing = 12
        stackView.axis = .vertical
        titleLbl.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        autherLbl.textAlignment = .right
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
