//
//  AppsController.swift
//  AppStore
//
//  Created by Xpress Integration on 4/24/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit
import IHProgressHUD

class AppsPageController: BaseListController, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    let headerId = "headerId"
    var socialMediaApps = [SocialApp]()
    var groups = [AppGroup]()
    var group1: AppGroup?
    var group2: AppGroup?
    var group3: AppGroup?
    
    let networkProvider = NetworkManager()
    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        fetchGamesApps()
        fetchTopGrossingApps()
        fetchTopFreeApps()
        fetchSocialMediaApps()
        dispatchGroup.notify(queue: .main) {
            IHProgressHUD.dismiss()
            if let group1 = self.group1 {
                self.groups.append(group1)
            }
            if let group2 = self.group2 {
                self.groups.append(group2)
            }
            if let group3 = self.group3 {
                self.groups.append(group3)
            }
            self.collectionView.reloadData()
        }
    }
    
    var editorsChoiceGame: AppGroup?
    
    func fetchGamesApps() {
        IHProgressHUD.show()
        dispatchGroup.enter()
        networkProvider.fetchiTunesGamesApps { (appGroup, error) in
            self.dispatchGroup.leave()
            if let error = error {
                print("Failed to fetch app group", error)
                return
            }
            self.editorsChoiceGame = appGroup
            guard let appGroup = appGroup else { return }
            self.group1 = appGroup
        }
    }
    
    func fetchTopGrossingApps() {
        IHProgressHUD.show()
        dispatchGroup.enter()
        networkProvider.fetchTopGrossingApps { (appGroup, error) in
            self.dispatchGroup.leave()
            if let error = error {
                print("Failed to fetch app group", error)
                return
            }
            self.editorsChoiceGame = appGroup
            guard let appGroup = appGroup else { return }
            self.group2 = appGroup
        }
    }
    
    func fetchTopFreeApps() {
        IHProgressHUD.show()
        dispatchGroup.enter()
        networkProvider.fetchTopFreeApps { (appGroup, error) in
            self.dispatchGroup.leave()
            if let error = error {
                print("Failed to fetch app group", error)
                return
            }
            self.editorsChoiceGame = appGroup
            guard let appGroup = appGroup else { return }
            self.group3 = appGroup
        }
    }
    
    func fetchSocialMediaApps() {
        IHProgressHUD.show()
        dispatchGroup.enter()
        networkProvider.fetchSocialMediaApps { (socialMediaApps, error) in
            self.dispatchGroup.leave()
            if let error = error {
                return
            }
            guard let socialMediaApps = socialMediaApps else { return }
            self.socialMediaApps = socialMediaApps
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsPageHeader
        header.appHeaderHorizontalController.socialMediaApps = socialMediaApps
        header.appHeaderHorizontalController.collectionView.reloadData()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: self.view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppGroupCell
        cell.titleLabel.text = groups[indexPath.item].feed.title
        cell.appHorizontalController.appGroup = groups[indexPath.item]
        cell.appHorizontalController.collectionView.reloadData()
        cell.appHorizontalController.didSelectHandler = { [weak self] feedResult in
            guard let self = self else { return }
            let appDetailController = AppDetailController(appId: feedResult.id)
            appDetailController.title = feedResult.name
            self.navigationController?.pushViewController(appDetailController, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}
