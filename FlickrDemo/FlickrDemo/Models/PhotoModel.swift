//
//  PhotoModel.swift
//  FlickrDemo
//
//  Created by Wojciech Charysz on 13.02.18.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation

///The protocol defines properties representing Author's photo.
protocol PhotoModel {
    
    /// Photo title
    var title: String? {get set}
    
    /// Date when the photo was published on Flickr
    var publishDate: Date? {get set}
    
    /// URL link to the photo file.
    var imageURL: URL? {get set}
}
