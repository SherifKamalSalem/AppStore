//
//  TodayFullscreenHeaderCell.swift
//  AppStore
//
//  Created by Xpress Integration on 5/1/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

class TodayFullscreenHeaderCell: UICollectionReusableView {
    
    let categoryLbl = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titlLbl = UILabel(text: "Utilizing your time", font: .boldSystemFont(ofSize: 32), numberOfLines: 2)
    
    var todayItem: TodayItem? {
        didSet {
            categoryLbl.text = todayItem?.category
            titlLbl.text = todayItem?.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let stackView = UIStackView(arrangedSubviews: [
            categoryLbl,
            titlLbl
        ])
        stackView.axis = .vertical
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
