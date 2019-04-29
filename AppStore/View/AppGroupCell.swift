//
//  AppGroupCell.swift
//  AppStore
//
//  Created by Xpress Integration on 4/24/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

class AppGroupCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: " App Section", font: UIFont.boldSystemFont(ofSize: 30))
    let appHorizontalController = AppHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        addSubview(appHorizontalController.view)
        appHorizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
