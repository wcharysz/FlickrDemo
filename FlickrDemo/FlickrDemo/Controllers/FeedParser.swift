//
//  FeedParser.swift
//  FlickrDemo
//
//  Created by Wojciech Charysz on 10.02.18.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation
import SWXMLHash

/// The FeedParser class is used to parse RSS feed from the Flickr.
class FeedParser {
    
    /// Date formatter used to convert string dates into Date object.
    let formatter = ISO8601DateFormatter()
    
    /**
     This function parses the RSS XML into PhotosPackage. If the xml does not contain required elements it will deliver PhotosPackage with an empty array of Photos.
     - Parameter data: The Data object which represents Flick RSS xml.
     - Returns: The PhotoPackage which contains an array of Photos conforming to the PhotoModel & AuthorModel protocols.
    */
    func parse(_ data: Data) -> PhotosPackage {
        let xml = XMLHash.parse(data)
        
        let entries = xml["feed"]["entry"]
        let photos = entries.all.map { (entry) -> PhotoModel & AuthorModel in
            let title = entry["title"].element?.text
            let dateString = entry["published"].element?.text ?? ""
            let date = formatter.date(from: dateString)
            let url = entry["link"].all.reduce("", { (result, item) -> String in
                return item.element?.attribute(by: "href")?.text ?? result
            })
            let name = entry["author"]["name"].element?.text
            let uri = entry["author"]["uri"].element?.text ?? ""
            let icon = entry["author"]["flickr:buddyicon"].element?.text ?? ""
           
            return Photo(name: name, buddyIcon: URL(string: icon), uri: URL(string: uri), title: title, publishDate: date, imageURL: URL(string: url))
        }
        
        return PhotosPackage(photos: photos)
    }
}
