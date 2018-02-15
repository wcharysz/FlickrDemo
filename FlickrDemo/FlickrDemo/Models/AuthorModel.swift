//
//  AuthorModel.swift
//  FlickrDemo
//
//  Created by Wojciech Charysz on 13.02.18.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation

///The protocol defines properties representing Author's photo.
protocol AuthorModel {
    
    /// Photo Author name.
    var name: String? {get set}
    
    /// URL link to the author's avatar.
    var buddyIcon: URL? {get set}
    
    /// URL link to the author's Flickr web page.
    var uri: URL? {get set}
}
