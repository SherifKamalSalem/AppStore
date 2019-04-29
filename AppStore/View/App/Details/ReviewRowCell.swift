//
//  ReviewCell.swift
//  AppStore
//
//  Created by Xpress Integration on 4/29/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
    
    let reviewLbl = UILabel(text: "Reviews & Ratings", font: .boldSystemFont(ofSize: 20))
    
    let reviewController = ReviewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(reviewLbl)
        addSubview(reviewController.view)
        reviewLbl.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        reviewController.view.anchor(top: reviewLbl.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
