//
//  ScreenshotCell.swift
//  AppStore
//
//  Created by Xpress Integration on 4/29/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

class ScreenshotCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 12)
    
    var screenshotUrl: String? {
        didSet {
            imageView.sd_setImage(with: URL(string: screenshotUrl ?? ""))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.backgroundColor = .red
        imageView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
