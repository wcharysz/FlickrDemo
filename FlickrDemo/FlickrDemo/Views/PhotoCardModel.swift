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
class PhotoCardModel: ObservableObject {
    
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

    init(_ photoCard: PhotoCard?) {
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
    @Published var photoTitle: String? {
        didSet {
            view?.titleLabel.text = photoTitle
        }
    }
    
    /// The url of the photo. It's downloaded by the Alamofire and processed by AlamofireImage framework. It's displayed by the PhotoCard imageView.
    @Published var imageURL: URL? {
        didSet {
            if let url = imageURL, let imageView = view?.imageView  {
                AF.request(url).responseImage(completionHandler: { (response) in
                    switch response.result {
                    case .success(let image):
                        imageView.image = image
                    default:
                        break
                    }
                    
                    
                })
            }
        }
    }
    
    /// The publish date of the photo. It's displayed by the PhotoCard dateLabel using dateFormatter to provide date string.
    @Published var publishDate: Date? {
        didSet {
            if let date = publishDate {
                let text = dateFormatter.string(from: date)
                view?.dateLabel.text = text
                publishDateString = text
            }
        }
    }
    
    @Published var publishDateString: String = ""
    
    /// The author's name of the photo. It's displayed by the PhotoCard authorName label.
    @Published var authorName: String? {
        didSet {
            view?.authorName.text = authorName
        }
    }
    
    /// The uri link of the photo's author Flickr web page. It's displayed by the PhotoCard linkLabel.
    @Published var uri: URL? {
        didSet {
            view?.linkLabel.text = uri?.absoluteString
        }
    }
    
    /// The url of the photo. It's downloaded by the Alamofire and processed by AlamofireImage framework. It's displayed by the PhotoCard authorView.
    @Published var buddyIcon: URL? {
        didSet {
            if let url = buddyIcon, let imageView = view?.authorView  {
                AF.request(url).responseImage(completionHandler: { (response) in
                    switch response.result {
                    case .success(let image):
                        imageView.image = image
                    default:
                        break
                    }
                    
                })
            }
        }
    }
    
    /// Opens external Safari with the uri link of the photo's author Flickr web page.
    func openLinkInSafari() {
        if let url = uri {
            UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([convertFromUIApplicationOpenExternalURLOptionsKey(UIApplication.OpenExternalURLOptionsKey.universalLinksOnly): false]), completionHandler: nil)
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIApplicationOpenExternalURLOptionsKey(_ input: UIApplication.OpenExternalURLOptionsKey) -> String {
	return input.rawValue
}
