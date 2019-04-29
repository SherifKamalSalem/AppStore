//
//  SearchResult.swift
//  AppStore
//
//  Created by Xpress Integration on 4/19/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}
