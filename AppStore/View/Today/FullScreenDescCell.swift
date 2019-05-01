//
//  FullScreenDescCell.swift
//  AppStore
//
//  Created by Xpress Integration on 4/29/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

class FullScreenDescCell: UITableViewCell {

    let descLbl: UILabel = {
        let lbl = UILabel()
        let attributedText = NSMutableAttributedString(string: "Great Games", attributes: [.foregroundColor : UIColor.black])
        attributedText.append(NSAttributedString(string: "are all about the details, for subtile visual effects.", attributes: [.foregroundColor : UIColor.gray]))
        
        lbl.attributedText = attributedText
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        addSubview(descLbl)
        descLbl.fillSuperview(padding: .init(top: 0, left: 24, bottom: 0, right: 24))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
