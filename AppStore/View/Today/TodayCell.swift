//
//  TodayCell.swift
//  AppStore
//
//  Created by Xpress Integration on 4/29/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

class TodayCell: BaseTodayCell {
    
    let categoryLbl = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titlLbl = UILabel(text: "Utilizing your time", font: .boldSystemFont(ofSize: 28))
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    let descLbl = UILabel(text: "All the tools you need to organize your life intelligently", font: .systemFont(ofSize: 20))
    
    var topConstraint: NSLayoutConstraint?
    
    override var todayItem: TodayItem? {
        didSet {
            titlLbl.text = todayItem?.title
            categoryLbl.text = todayItem?.category
            descLbl.text = todayItem?.description
            imageView.image = todayItem?.image
            backgroundColor = todayItem?.backgroundColor
            backgroundView?.backgroundColor = todayItem?.backgroundColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        descLbl.numberOfLines = 2
        layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        let containerView = UIView()
        containerView.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 240, height: 200))
        let stackView = UIStackView(arrangedSubviews: [categoryLbl, titlLbl, containerView, descLbl], customSpacing: 8)
        stackView.axis = .vertical
        addSubview(stackView)
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 24, right: 24))
        self.topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        self.topConstraint?.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
