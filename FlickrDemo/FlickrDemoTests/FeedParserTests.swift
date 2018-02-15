//
//  FeedParserTests.swift
//  FlickrDemoTests
//
//  Created by Wojciech Charysz on 10.02.18.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import XCTest

class FeedParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParse() {
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "TestFeed", ofType: "xml"), let data = FileManager.default.contents(atPath: path) else {
           XCTAssert(false, "No sample xml to test parsing")
            return
        }
        
        let parser = FeedParser()
        let package = parser.parse(data)
        let isCountCorrect = package.photos?.count == 20
        
        XCTAssert(isCountCorrect, "Not all entries could be parsed")
        
        
        guard let photos = package.photos else {
            XCTAssert(false, "No photos could be parsed to test")
            return
        }
        
        for photo in photos {
            XCTAssertNotNil(photo.buddyIcon)
            XCTAssertNotNil(photo.imageURL)
            XCTAssertNotNil(photo.name)
            XCTAssertNotNil(photo.title)
            XCTAssertNotNil(photo.publishDate)
            XCTAssertNotNil(photo.uri)
        }
    }
    
}
