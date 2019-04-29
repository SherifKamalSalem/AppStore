//
//  AppDetailController.swift
//  AppStore
//
//  Created by Xpress Integration on 4/28/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let previewCellId = "previewCellId"
private let reviewCellId = "reviewCellId"

class AppDetailController: BaseListController, UICollectionViewDelegateFlowLayout {

    let networkProvider = NetworkManager()
    
    var app: Result?
    var review: Review?
    
    var appId: String! {
        didSet {
            fetchAppDetails(appId: appId)
            fetchAppReviews(appId: appId)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        self.collectionView!.register(AppDetailCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView!.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellId)
        self.collectionView!.register(ReviewRowCell.self, forCellWithReuseIdentifier: reviewCellId)
    }
    
    func fetchAppDetails(appId: String) {
        networkProvider.fetchAppDetails(appId: appId) { (result, error) in
            if let error = error {
                print("Failed to fetch app details, ", error)
                return
            }
            guard let app = result?.results.first else { return }
            self.app = app
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func fetchAppReviews(appId: String) {
        networkProvider.fetchAppReviews(appId: appId) { (review, error) in
            if let error = error {
                print("Failed to fetch app reviews ", error)
                return
            }
            guard let review = review else { return }
            self.review = review
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            let cell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            cell.app = app
            cell.layoutIfNeeded()
            let estimatedSize = cell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            return .init(width: view.frame.width, height: estimatedSize.height)
        } else if indexPath.item == 1 {
            return .init(width: view.frame.width, height: 500)
        } else {
            return .init(width: view.frame.width, height: 280)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AppDetailCell
            cell.app = app
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! PreviewCell
            cell.previewScreenshotController.app = app
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! ReviewRowCell
            cell.reviewController.review = review
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 16, right: 0)
    }
}
