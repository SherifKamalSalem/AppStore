//
//  AppFullScreenController.swift
//  AppStore
//
//  Created by Xpress Integration on 4/29/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

class AppFullScreenController: UITableViewController {

    var todayItem: TodayItem?
    
    var dismissHandler: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        let height = UIApplication.shared.statusBarFrame.height
        tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = AppFullScreenHeaderCell()
            cell.closeBtn.addTarget(self, action: #selector(handleDismiss(btn:)), for: .touchUpInside)
            cell.todayCell.todayItem = todayItem
            cell.todayCell.layer.cornerRadius = 0
            cell.clipsToBounds = true
            return cell
        }
        let cell = FullScreenDescCell()
        cell.clipsToBounds = false
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 500
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    @objc fileprivate func handleDismiss(btn: UIButton) {
        btn.isHidden = true
        dismissHandler?()
    }
}
