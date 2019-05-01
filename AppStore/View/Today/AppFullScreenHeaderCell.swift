//
//  AppFullScreenHeaderCell.swift
//  AppStore
//
//  Created by Xpress Integration on 4/30/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

class AppFullScreenHeaderCell: UITableViewCell {

    let closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
        return btn
    }()
    
    var todayCell = TodayCell()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(todayCell)
        todayCell.fillSuperview()
        addSubview(closeBtn)
        closeBtn.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 44, left: 0, bottom: 0, right: 16), size: .init(width: 36, height: 36))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
