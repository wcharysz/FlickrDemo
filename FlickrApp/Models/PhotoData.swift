//
//  PhotoData.swift
//  FlickrApp
//
//  Created by Wojciech Charysz on 19.10.22.
//

import Foundation
import SWXMLHash

///The protocol defines properties representing Author's photo.
protocol PhotoModel: Equatable {
    
    /// Photo title
    var title: String? {get set}
    
    /// Date when the photo was published on Flickr
    var publishDate: Date? {get set}
    
    /// URL link to the photo file.
    var imageURL: URL? {get set}
}

///The protocol defines properties representing Author's photo.
protocol AuthorModel: Equatable {
    
    /// Photo Author name.
    var name: String? {get set}
    
    /// URL link to the author's avatar.
    var buddyIcon: URL? {get set}
    
    /// URL link to the author's Flickr web page.
    var uri: URL? {get set}
}

struct PhotoAuthor: AuthorModel, XMLObjectDeserialization {
    var name: String?
    
    var buddyIcon: URL?
    
    var uri: URL?
    
    static func deserialize(_ element: XMLIndexer) throws -> PhotoAuthor {
        try PhotoAuthor(name: element["author"]["name"].value(),
                        buddyIcon: URL(string: element["author"]["flickr:buddyicon"].value()),
                        uri: URL(string: element["author"]["uri"].value()))
    }
}

struct PhotoData: PhotoModel, XMLObjectDeserialization {
    var title: String?
    
    var publishDate: Date?
    
    var imageURL: URL?
    
    static func deserialize(_ element: XMLIndexer) throws -> PhotoData {
        try PhotoData(title: element["title"].value(),
                      publishDate: ISO8601DateFormatter().date(from: element["published"].value()),
                      imageURL: URL(string: element["link"].all.reduce("", { (result, item) -> String in
                                                                item.element?.attribute(by: "href")?.text ?? result
        })))
    }
}

struct PhotoContainer: XMLObjectDeserialization, Equatable {
    var entries: [Photo.State]
    
    static func deserialize(_ element: XMLIndexer) throws -> PhotoContainer {
        try PhotoContainer(entries: element["feed"]["entry"].all.map({ entry in
            let author: PhotoAuthor = try entry.value()
            let data: PhotoData = try entry.value()
            
            return Photo.State(author: author, photo: data)
        }))
    }
}
