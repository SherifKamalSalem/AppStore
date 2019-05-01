//
//  BaseListController.swift
//  AppStore
//
//  Created by Xpress Integration on 4/24/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class BaseListController: UICollectionViewController {

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
