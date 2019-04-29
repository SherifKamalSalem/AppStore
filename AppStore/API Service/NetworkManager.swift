//
//  NetworkManager.swift
//  AppStore
//
//  Created by Xpress Integration on 4/19/19.
//  Copyright © 2019 Xpress Integration. All rights reserved.
//

import Foundation
import Moya

class NetworkManager {
    internal let provider = MoyaProvider<BaseAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    let jsonDecoder = JSONDecoder()
    
    typealias Callback<T: Decodable> = (T?, Error?) -> ()
    
    func fetchiTunesApps(searchTerm: String, completion: @escaping Callback<SearchResult>) {
        fetchGenericData(endPoint: .getiTunesApps(searchTerm: searchTerm), completion: completion)
    }
    
    func fetchiTunesGamesApps(completion: @escaping Callback<AppGroup>) {
        fetchGenericData(endPoint: .getGamesApps, completion: completion)
    }
    
    func fetchTopGrossingApps(completion: @escaping Callback<AppGroup>) {
        fetchGenericData(endPoint: .getTopGrossingApps, completion: completion)
    }
    
    func fetchTopFreeApps(completion: @escaping Callback<AppGroup>) {
        fetchGenericData(endPoint: .getTopFreeApps, completion: completion)
    }
    
    func fetchSocialMediaApps(completion: @escaping Callback<[SocialApp]>) {
        fetchGenericData(endPoint: .getSocialMediaApps, completion: completion)
    }
    
    func fetchAppDetails(appId: String, completion: @escaping Callback<SearchResult>) {
        fetchGenericData(endPoint: .getAppDetails(appId: appId), completion: completion)
    }
    
    func fetchAppReviews(appId: String, completion: @escaping Callback<Review>) {
        fetchGenericData(endPoint: .getAppReviews(appId: appId), completion: completion)
    }
    
    func fetchGenericData<T: Decodable>(endPoint: BaseAPI, completion: @escaping Callback<T>) {
        provider.request(endPoint) { (result) in
            switch result {
            case let .success(response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let objects = try filteredResponse.map(T.self)
                    
                    completion(objects, nil)
                }
                catch let error {
                    print("error: \(error)")
                }
                
            case let .failure(error):
                print("err: \(error)")
                completion(nil, error)
            }
        }
    }
}
