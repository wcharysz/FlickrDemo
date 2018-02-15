//
//  PhotosPackage.swift
//  FlickrDemo
//
//  Created by Wojciech Charysz on 09.02.18.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation

/// Container for the parsed photos.
struct PhotosPackage {
    
    /// Aray of the photos conforming to the PhotoModel and AuthorModel protocols.
    var photos: [PhotoModel & AuthorModel]?
}
