//
//  Review.swift
//  AppStore
//
//  Created by Xpress Integration on 4/29/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import Foundation

struct Review: Decodable {
    let feed: ReviewFeed
}

struct ReviewFeed: Decodable {
    let entry: [Entry]
}

struct Entry: Decodable {
    let title: Label
    let author: Author
    let content: Label
    
    let rating: Label
    
    private enum CodingKeys: String, CodingKey {
        case title, author, content
        case rating = "im:rating"
    }
}

struct Label: Decodable {
    let label: String
}

struct Author: Decodable {
    let name: Label
}
