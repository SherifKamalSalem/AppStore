//
//  TodayMultipleAppCell.swift
//  AppStore
//
//  Created by Xpress Integration on 4/30/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

class TodayMultipleAppCell: BaseTodayCell {

    let categoryLbl = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titlLbl = UILabel(text: "Utilizing your time", font: .boldSystemFont(ofSize: 32), numberOfLines: 2)
    
    let todayMultiAppsController = TodayMultipleAppsController(mode: .small)
    
    override var todayItem: TodayItem? {
        didSet {
            categoryLbl.text = todayItem?.category
            titlLbl.text = todayItem?.title
            todayMultiAppsController.apps = todayItem?.apps ?? []
            todayMultiAppsController.collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let stackView = UIStackView(arrangedSubviews: [
            categoryLbl,
            titlLbl,
            todayMultiAppsController.view
        ])
        stackView.axis = .vertical
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
