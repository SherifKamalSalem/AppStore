//
//  TodayMultipleAppsController.swift
//  AppStore
//
//  Created by Xpress Integration on 4/30/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit
import IHProgressHUD

private let reuseIdentifier = "Cell"
private let fullscreenId = "fullscreenId"

enum Mode {
    case small, fullscreen
}

class TodayMultipleAppsController: BaseListController, UICollectionViewDelegateFlowLayout {

    let closeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
        btn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        btn.tintColor = .darkGray
        return btn
    }()
    
    fileprivate let mode: Mode
    let networkProvider = NetworkManager()
    var apps = [FeedResult]()
    
    init(mode: Mode) {
        self.mode = mode
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        if mode == .fullscreen {
            setupCloseBtn()
            navigationController?.isNavigationBarHidden = true
            collectionView.isScrollEnabled = true
        }
        self.collectionView!.register(TodayFullscreenHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: fullscreenId)
        self.collectionView!.register(MultipleAppCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    fileprivate func setupCloseBtn() {
        view.addSubview(closeBtn)
        closeBtn.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 16), size: .init(width: 36, height: 36))
    }
    
    @objc func handleDismiss() {
        self.dismiss(animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if mode == .fullscreen {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: fullscreenId, for: indexPath) as! TodayFullscreenHeaderCell
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if mode == .fullscreen {
            return .init(width: self.view.frame.width, height: 120)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if mode == .fullscreen {
            return .init(top: 12, left: 24, bottom: 12, right: 24)
        } else {
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 74//(view.frame.height - 3 * 16) / 4
        if mode == .fullscreen {
            return .init(width: self.view.frame.width - 48, height: height)
        }
        return .init(width: self.view.frame.width, height: height)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mode == .fullscreen {
            return apps.count
        }
        return min(4, apps.count)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MultipleAppCell
        cell.result = apps[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appId = apps[indexPath.item].id
        let appDetailController = AppDetailController(appId: appId)
        navigationController?.pushViewController(appDetailController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
