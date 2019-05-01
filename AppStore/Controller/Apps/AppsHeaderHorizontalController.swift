//
//  AppsHeaderHorizontalController.swift
//  AppStore
//
//  Created by Xpress Integration on 4/26/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class AppsHeaderHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {

    var socialMediaApps = [SocialApp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppsHeaderHorizontalCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialMediaApps.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AppsHeaderHorizontalCell
        cell.socialMediaApp = socialMediaApps[indexPath.item]
        return cell
    }
}
