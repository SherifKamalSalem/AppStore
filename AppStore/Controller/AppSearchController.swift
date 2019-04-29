//
//  AppSearchController.swift
//  AppStore
//
//  Created by Xpress Integration on 4/17/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class AppSearchController: BaseListController, UICollectionViewDelegateFlowLayout {

    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let networkProvider = NetworkManager()
    fileprivate var appResults = [Result]()
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
        setupSearchBar()
        self.collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    fileprivate let enterSearchTermLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Please Enter Search Term above"
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.textAlignment = .center
        return lbl
    }()
    
    fileprivate func fetchiTunesApps(searchTerm: String) {
        networkProvider.fetchiTunesApps(searchTerm: searchTerm) { (searchResult, error) in
            if let error = error {
                print("Failed to fetch search results", error)
                return
            }
            
            guard let searchResult = searchResult else { return }
            self.appResults = searchResult.results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SearchResultCell
        let result = appResults[indexPath.item]
        cell.result = result
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = appResults.count != 0
        return appResults.count
    }
}

extension AppSearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.fetchiTunesApps(searchTerm: searchText)
        })
    }
}

