//
//  PreviewScreenshotController.swift
//  AppStore
//
//  Created by Xpress Integration on 4/29/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PreviewScreenshotController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {

    var app: Result? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        self.collectionView!.register(ScreenshotCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: view.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.screenshotUrls.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ScreenshotCell
        cell.screenshotUrl = app?.screenshotUrls[indexPath.item]
        return cell
    }
}
