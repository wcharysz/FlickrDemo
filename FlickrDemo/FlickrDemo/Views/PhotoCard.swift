//
//  PhotoCard.swift
//  FlickrDemo
//
//  Created by Wojciech Charysz on 10.02.18.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import UIKit

class PhotoCard: UIView {

    @IBOutlet weak var authorView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var linkLabel: UILabel!

    lazy var viewModel: PhotoCardModel = {
        return PhotoCardModel(self)
    }()
    
    @IBAction func linkLabelTap() {
        viewModel.openLinkInSafari()
    }
}
