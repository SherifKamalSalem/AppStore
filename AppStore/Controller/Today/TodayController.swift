//
//  TodayController.swift
//  AppStore
//
//  Created by Xpress Integration on 4/29/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit
import IHProgressHUD

class TodayController: BaseListController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {

    var startingFrame: CGRect?
    var fullscreenController: AppFullScreenController!
    var anchoredConstraints: AnchoredConstraints?
    let networkProvider = NetworkManager()
    
    var topGrossingGroup: AppGroup?
    var gamesGroup: AppGroup?
    
    var appFullscreenBeginOffset: CGFloat?
    
    var todayItems = [TodayItem]()
    
    let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    fileprivate func setupBlurEffectView() {
        view.addSubview(blurVisualEffectView)
        blurVisualEffectView.fillSuperview()
        blurVisualEffectView.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBlurEffectView()
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        fetchAppsData()
        self.collectionView!.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        self.collectionView!.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
    }
    
    fileprivate func fetchAppsData() {
        IHProgressHUD.show()
        let dispachGroup = DispatchGroup()
        dispachGroup.enter()
        networkProvider.fetchTopGrossingApps { (appGroup, error) in
            if let error = error {
                print("Failed to fetch app group", error)
                return
            }
            dispachGroup.leave()
            guard let topGrossingGroup = appGroup else { return }
            self.topGrossingGroup = topGrossingGroup
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        dispachGroup.enter()
        networkProvider.fetchiTunesGamesApps { (appGroup, error) in
            if let error = error {
                print("Failed to fetch app group", error)
                return
            }
            dispachGroup.leave()
            guard let gamesGroup = appGroup else { return }
            self.gamesGroup = gamesGroup
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        dispachGroup.notify(queue: .main) {
            self.collectionView.reloadData()
            IHProgressHUD.dismiss()
            self.todayItems = [
                TodayItem(category: "THE DIALY LIST", title: self.topGrossingGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "All tools and apps you need to intelligently organize your time", backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), apps: self.topGrossingGroup?.feed.results ?? [], cellType: .multiple),
                TodayItem(category: "THE DIALY LIST", title: self.gamesGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "All tools and apps you need to intelligently organize your time", backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), apps: self.gamesGroup?.feed.results ?? [], cellType: .multiple),
                TodayItem(category: "LIFE HACK", title: "Utilizing your time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life right away", backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), apps: [], cellType: .single),
                TodayItem(category: "LIFE HACK", title: "Utilizing your time", image: #imageLiteral(resourceName: "Happy-Holidays"), description: "All the tools and apps you need to intelligently organize your life right away", backgroundColor: #colorLiteral(red: 1, green: 0.9662353396, blue: 0.5257281661, alpha: 1), apps: [], cellType: .single)
            ]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.setNeedsLayout()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: 500)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = todayItems[indexPath.row].cellType.rawValue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
        cell.todayItem = todayItems[indexPath.row]
        (cell as? TodayMultipleAppCell)?.todayMultiAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppTap(gesture:))))
        return cell
    }
    
    @objc func handleMultipleAppTap(gesture: UIGestureRecognizer) {
        let collectionView = gesture.view
        var cVSuperView = collectionView?.superview
        while cVSuperView != nil {
            if let cell = cVSuperView as? TodayMultipleAppCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                let apps = self.todayItems[indexPath.item].apps
                let fullscreenController = TodayMultipleAppsController(mode: .fullscreen)
                fullscreenController.apps = apps
                present(BackEnabledNavController(rootViewController: fullscreenController), animated: true)
            }
            cVSuperView = cVSuperView?.superview
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
    
    fileprivate func showDialyListFullscreen(_ indexPath: IndexPath) {
        let multipleAppsController = TodayMultipleAppsController(mode: .fullscreen)
        multipleAppsController.apps = todayItems[indexPath.item].apps
        present(BackEnabledNavController(rootViewController: multipleAppsController), animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cellType = todayItems[indexPath.item].cellType
        switch cellType {
        case .multiple:
            showDialyListFullscreen(indexPath)
        case .single:
            showSingleFullscreen(indexPath: indexPath)
        }
    }
    
    fileprivate func showSingleFullscreen(indexPath: IndexPath) {
        setupFullscreenController(indexPath: indexPath)
        setupSingleAppFScreenStartingPosition(indexPath: indexPath)
        beginFullscreenAnimation()
    }
    
    fileprivate func setupFullscreenController(indexPath: IndexPath) {
        let fullScreenController = AppFullScreenController()
        fullScreenController.todayItem = todayItems[indexPath.item]
        fullScreenController.dismissHandler = {
            self.handleFullscreenDismissal()
        }
        self.fullscreenController = fullScreenController
        self.fullscreenController.view.layer.cornerRadius = 16
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleDrag(gesture:)))
        gesture.delegate = self
        self.fullscreenController.view.addGestureRecognizer(gesture)
    }
    
    @objc fileprivate func handleDrag(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            self.appFullscreenBeginOffset = self.fullscreenController.tableView.contentOffset.y
        }
        
        if self.fullscreenController.tableView.contentOffset.y > 0 {
            return
        }
        
        let transitionY = gesture.translation(in: self.fullscreenController.view).y
        
        if gesture.state == .changed {
            if transitionY > 0 {
                let trueOffset = transitionY - appFullscreenBeginOffset!
                var scale = 1 - trueOffset / 1000
                scale = min(1, scale)
                scale = max(0.5, scale)
                let transform = CGAffineTransform(scaleX: scale, y: scale)
                self.fullscreenController.view.transform = transform
            }
        } else if gesture.state == .ended {
            if transitionY > 0 {
                handleFullscreenDismissal()
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    fileprivate func setupSingleAppFScreenStartingPosition(indexPath: IndexPath) {
        let fullScreenView = self.fullscreenController.view!
        view.addSubview(fullScreenView)
        addChild(fullscreenController)
        self.collectionView.isUserInteractionEnabled = false
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
        fullScreenView.translatesAutoresizingMaskIntoConstraints = false
        self.anchoredConstraints = fullScreenView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0), size: .init(width: startingFrame.width, height: startingFrame.height))
        
        self.view.layoutIfNeeded()
    }
    
    fileprivate func beginFullscreenAnimation() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.blurVisualEffectView.alpha = 1
            self.anchoredConstraints?.top?.constant = 0
            self.anchoredConstraints?.leading?.constant = 0
            self.anchoredConstraints?.width?.constant = self.view.frame.width
            self.anchoredConstraints?.height?.constant = self.view.frame.height
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            guard let cell = self.fullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderCell else { return }
            cell.todayCell.topConstraint?.constant = 48
            cell.layoutIfNeeded()
        })
    }
    
    @objc func handleFullscreenDismissal() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.blurVisualEffectView.alpha = 0
            self.fullscreenController.view.transform = .identity
            self.fullscreenController.tableView.contentOffset = .zero
            self.anchoredConstraints?.top?.constant = self.startingFrame?.origin.y ?? 0
            self.anchoredConstraints?.leading?.constant = self.startingFrame?.origin.x ?? 0
            self.anchoredConstraints?.width?.constant = self.startingFrame?.width ?? 0
            self.anchoredConstraints?.height?.constant = self.startingFrame?.height ?? 0
            guard let cell = self.fullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderCell else { return }
            cell.todayCell.topConstraint?.constant = 24
            self.fullscreenController.closeBtn.alpha = 0
            cell.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.collectionView.isUserInteractionEnabled = true
            self.tabBarController?.tabBar.transform = .identity
            self.fullscreenController.view.removeFromSuperview()
            self.fullscreenController.removeFromParent()
        })
    }
}
