//
//  FeedParser.swift
//  FlickrApp
//
//  Created by Wojciech Charysz on 19.10.22.
//

import Foundation
import SWXMLHash
import Combine
import ComposableArchitecture

struct FeedParser {
    
    var parseFeedPublisher: (Data) -> AnyPublisher<PhotoContainer, Error>
    var parseFeed: (Data) throws -> PhotoContainer
    
    enum FeedParserError: Error {
        case wrongData
    }
}


extension FeedParser {
    
    static let live = FeedParser(parseFeedPublisher: { data in
        let xml = XMLHash.parse(data)

        do {
            let result: PhotoContainer = try xml.value()
            
            return Just(result)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
        } catch let error {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }, parseFeed: { data in
        try XMLHash.parse(data).value()
    })
    
    static let mock = FeedParser { data in
        let url = Bundle.main.url(forResource: "TestFeed", withExtension: "xml")
        
        guard let url = url else {
            return Fail(error: FeedParserError.wrongData).eraseToAnyPublisher()
        }
        
        do {
            let sampleData = try Data(contentsOf: url)
            let xml = XMLHash.parse(sampleData)
            
            let result: PhotoContainer = try xml.value()
            
            return Just(result)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
        } catch let error {
            return Fail(error: error).eraseToAnyPublisher()
        }
    } parseFeed: { data in
        let url = Bundle.main.url(forResource: "TestFeed", withExtension: "xml")
        
        guard let url = url else {
            throw FeedParserError.wrongData
        }
        
        let sampleData = try Data(contentsOf: url)
        let xml = XMLHash.parse(sampleData)

        return try xml.value()
    }
}


extension FeedParser: DependencyKey {
    static var liveValue = FeedParser.live
    static var previewValue = FeedParser.mock
}

extension DependencyValues {
    var feedParser: FeedParser {
        get {
            self[FeedParser.self]
        }
        
        set {
            self[FeedParser.self] = newValue
        }
    }
}
