//
//  SearchResultCell.swift
//  AppStore
//
//  Created by Xpress Integration on 4/17/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit
import SDWebImage

class SearchResultCell: UICollectionViewCell {
    
    var result: Result! {
        didSet {
            nameLabel.text = result.trackName
            categoryLabel.text = result.primaryGenreName
            ratingsLabel.text = "Rating: \(result.averageUserRating ?? 0)"
            let url = URL(string: result.artworkUrl100)
            appIconImageView.sd_setImage(with: url)
            screenshot1ImageView.sd_setImage(with: URL(string: result.screenshotUrls[0]))
            if result.screenshotUrls.count > 1 {
                screenshot2ImageView.sd_setImage(with: URL(string: result.screenshotUrls[1]))
            }
            if result.screenshotUrls.count > 2 {
                screenshot3ImageView.sd_setImage(with: URL(string: result.screenshotUrls[2]))
            }
        }
    }
    
    let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "APP NAME"
        return lbl
    }()
    
    let categoryLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "APP NAME"
        return lbl
    }()
    
    let ratingsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "APP NAME"
        return lbl
    }()
    
    let getButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("GET", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        btn.layer.cornerRadius = 16
        btn.backgroundColor = UIColor(white: 0.95, alpha: 1)
        btn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }
    
    lazy var screenshot1ImageView = self.createScreenshotImageView()
    lazy var screenshot2ImageView = self.createScreenshotImageView()
    lazy var screenshot3ImageView = self.createScreenshotImageView()
    
    func createScreenshotImageView() -> UIImageView {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        iv.layer.borderWidth = 0.5
        iv.contentMode = .scaleAspectFill
        return iv
    }
    
    fileprivate func setupStackView() {
        let labelsStackView = UIStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingsLabel])
        labelsStackView.axis = .vertical
        let infoTopStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStackView, getButton])
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center
        let screenShotsStackView = UIStackView(arrangedSubviews: [screenshot1ImageView, screenshot2ImageView, screenshot3ImageView])
        screenShotsStackView.spacing = 12
        screenShotsStackView.distribution = .fillEqually
        let overallStackView = UIStackView(arrangedSubviews: [infoTopStackView, screenShotsStackView])
        overallStackView.axis = .vertical
        overallStackView.spacing = 12
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
