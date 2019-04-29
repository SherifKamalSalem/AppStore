//
//  Result.swift
//  AppStore
//
//  Created by Xpress Integration on 4/19/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import Foundation

struct Result: Decodable {
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String
    let formattedPrice: String
    let description: String
    let releaseNotes: String    
}
