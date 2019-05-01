//
//  TodayItem.swift
//  AppStore
//
//  Created by Xpress Integration on 4/30/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import UIKit

struct TodayItem {
    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor
    let apps: [FeedResult]
    
    let cellType: CellType
    
    enum CellType: String {
        case single, multiple
    }
}
