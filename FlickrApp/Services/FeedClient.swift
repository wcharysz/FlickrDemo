//
//  FeedClient.swift
//  FlickrApp
//
//  Created by Wojciech Charysz on 20.10.22.
//

import Foundation
import ComposableArchitecture


struct FeedClient {
    let fetchFeed: () async throws -> Data
    
    enum HTTPError: Error {
        case wrongURL
        case transportError(Error)
        case serverSideError(Int)
    }
}

extension FeedClient {
    static let live = FeedClient {
        let endPoint = "https://api.flickr.com/services/feeds/photos_public.gne"
        
        guard let url = URL(string: endPoint) else {
            throw FeedClient.HTTPError.wrongURL
        }
        
        let response = try await URLSession.shared.data(from: url)
        
        return response.0
    }
    
    static let mock = FeedClient {
        let localURL = Bundle.main.url(forResource: "TestFeed", withExtension: "xml")
        
        guard let localURL else {
            throw FeedClient.HTTPError.wrongURL
        }
        
        return try Data(contentsOf: localURL)
    }
}


extension FeedClient: DependencyKey {
    static var liveValue = FeedClient.live
    static var mockValue = FeedClient.mock
}

extension DependencyValues {
    var feedClient: FeedClient {
        get {
            self[FeedClient.self]
        }
        
        set {
            self[FeedClient.self] = newValue
        }
    }
}
