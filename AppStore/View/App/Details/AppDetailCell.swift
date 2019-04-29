//
//  AppDetailCell.swift
//  AppStore
//
//  Created by Xpress Integration on 4/28/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

class AppDetailCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 16)
    let nameLbl = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
    let priceBtn = UIButton(title: "$4.98")
    let whatsNewLbl = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))
    let releaseNotesLbl = UILabel(text: "Release Notes", font: .systemFont(ofSize: 18), numberOfLines: 0)
    
    var app: Result? {
        didSet {
            nameLbl.text = app?.trackName
            priceBtn.setTitle(app?.formattedPrice, for: .normal)
            releaseNotesLbl.text = app?.releaseNotes
            imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        imageView.backgroundColor = .red
        priceBtn.backgroundColor = #colorLiteral(red: 0.006895673559, green: 0.3584963709, blue: 0.8549019694, alpha: 1)
        priceBtn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        priceBtn.setTitleColor(.white, for: .normal)
        priceBtn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        priceBtn.layer.cornerRadius = 16
        priceBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        let vStackView = UIStackView(arrangedSubviews: [nameLbl, UIStackView(arrangedSubviews: [priceBtn, UIView()]), UIView()])
        vStackView.spacing = 12
        vStackView.axis = .vertical
        let avStackView = UIStackView(arrangedSubviews: [imageView, vStackView], customSpacing: 20)
        let stackView = UIStackView(arrangedSubviews: [avStackView, whatsNewLbl, releaseNotesLbl])
        stackView.spacing = 16
        stackView.axis = .vertical
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
        let seperatorView = UIView()
        seperatorView.backgroundColor = .gray
        addSubview(seperatorView)
        seperatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        seperatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}
