//
//  APIService.swift
//  AppStore
//
//  Created by Xpress Integration on 4/19/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import Foundation
import Moya

enum BaseAPI {
    case getiTunesApps(searchTerm: String)
    case getGamesApps
    case getTopGrossingApps
    case getTopFreeApps
    case getSocialMediaApps
    case getAppDetails(appId: String)
    case getAppReviews(appId: String)
}

extension BaseAPI: TargetType {
    var baseURL: URL {
        
        switch self {
        case .getiTunesApps:
            guard let url = URL(string: Constants.BASE_URL) else { fatalError("baseURL could not be configured.") }
            return url
        case .getGamesApps, .getTopGrossingApps, .getTopFreeApps:
            guard let url = URL(string: Constants.RSS_APPS_URL) else { fatalError("baseURL could not be configured.") }
            return url
        case .getSocialMediaApps:
            guard let url = URL(string: Constants.APPSTORE_SOCIAL_URL) else { fatalError("baseURL could not be configured.") }
            return url
        case .getAppDetails(let appId):
            guard let url = URL(string: "https://itunes.apple.com/lookup?id=\(appId)") else { fatalError("") }
            return url
        case .getAppReviews(let appId):
            guard let url = URL(string: "https://itunes.apple.com/rss/customerreviews/id=\(appId)/sortBy=mostRecent/json?l=en&cc=us") else { fatalError("") }
            return url
        }
    }
    
    var path: String {
        switch self {
        case .getiTunesApps:
            return "search"
        case .getGamesApps:
            return "new-games-we-love/all/50/explicit.json"
        case .getTopGrossingApps:
            return "top-grossing/all/50/explicit.json"
        case .getTopFreeApps:
            return "top-free/all/25/explicit.json"
        case .getSocialMediaApps:
            return ""
        case .getAppDetails, .getAppReviews:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getGamesApps, .getTopGrossingApps, .getTopFreeApps, .getSocialMediaApps, .getAppDetails, .getAppReviews, .getiTunesApps:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getiTunesApps(let searchTerm):
            return .requestParameters(parameters: [Constants.TERM : searchTerm, Constants.ENTITY : "software"], encoding: URLEncoding.queryString)
        case .getGamesApps, .getTopGrossingApps, .getTopFreeApps, .getSocialMediaApps, .getAppDetails, .getAppReviews:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
}
