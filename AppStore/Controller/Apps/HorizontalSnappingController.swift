//
//  HorizontalSnappingController.swift
//  AppStore
//
//  Created by Xpress Integration on 4/26/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class HorizontalSnappingController: UICollectionViewController {

    init() {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        self.collectionView.decelerationRate = .fast
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

