//
//  Photo.swift
//  FlickrDemo
//
//  Created by Wojciech Charysz on 09.02.18.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation

struct Photo: PhotoModel, AuthorModel {
    
    //MARK: - AuthorModel
    var name: String?
    var buddyIcon: URL?
    var uri: URL?
    
    //MARK: - PhotoModel
    var title: String?
    var publishDate: Date?
    var imageURL: URL?
}
