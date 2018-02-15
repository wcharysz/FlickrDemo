//
//  PhotoCardModel.swift
//  FlickrDemo
//
//  Created by Wojciech Charysz on 10.02.18.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

/// PhotoCardModel is used together with the PhotoCard to provide content for this UIView.
class PhotoCardModel {
    
    /// The reference to the displayed PhotoCard view.
    private weak var view: PhotoCard?
    
    /** DateFormatter used to create string representation of the dates. It's using:
        - TimeZone.current,
        - dateStyle is .medium
        - timeStyle is .short.
        - locale is Locale.current
    */
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale.current
        
        return formatter
    }()

    init(_ photoCard: PhotoCard) {
        view = photoCard
    }
    
    /// The model of the photo conforming to PhotoModel & AuthorModel protocols. It provides content for the PhotoCard view.
    var photo: (PhotoModel & AuthorModel)? {
        didSet {
            photoTitle = photo?.title
            imageURL = photo?.imageURL
            publishDate = photo?.publishDate
            buddyIcon = photo?.buddyIcon
            uri = photo?.uri
            authorName = photo?.name
        }
    }
    
    /// The title of the photo. It's displayed by the PhotoCard titleLabel.
    private var photoTitle: String? {
        didSet {
            view?.titleLabel.text = photoTitle
        }
    }
    
    /// The url of the photo. It's downloaded by the Alamofire and processed by AlamofireImage framework. It's displayed by the PhotoCard imageView.
    private var imageURL: URL? {
        didSet {
            if let url = imageURL {
                Alamofire.request(url).responseImage(completionHandler: { (response) in
                    self.view?.imageView.image = response.result.value
                })
            }
        }
    }
    
    /// The publish date of the photo. It's displayed by the PhotoCard dateLabel using dateFormatter to provide date string.
    private var publishDate: Date? {
        didSet {
            if let date = publishDate {
                view?.dateLabel.text = dateFormatter.string(from: date)
            }
        }
    }
    
    /// The author's name of the photo. It's displayed by the PhotoCard authorName label.
    private var authorName: String? {
        didSet {
            view?.authorName.text = authorName
        }
    }
    
    /// The uri link of the photo's author Flickr web page. It's displayed by the PhotoCard linkLabel.
    private var uri: URL? {
        didSet {
            view?.linkLabel.text = uri?.absoluteString
        }
    }
    
    /// The url of the photo. It's downloaded by the Alamofire and processed by AlamofireImage framework. It's displayed by the PhotoCard authorView.
    private var buddyIcon: URL? {
        didSet {
            if let url = buddyIcon {
                Alamofire.request(url).responseImage(completionHandler: { (response) in
                    self.view?.authorView.image = response.result.value
                })
            }
        }
    }
    
    /// Opens external Safari with the uri link of the photo's author Flickr web page.
    func openLinkInSafari() {
        if let url = uri {
            UIApplication.shared.open(url, options: [UIApplicationOpenURLOptionUniversalLinksOnly: false], completionHandler: nil)
        }
    }
}
