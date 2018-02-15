//
//  Networking.swift
//  FlickrDemo
//
//  Created by Wojciech Charysz on 10.02.18.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash

/// The Networking class is used to download RSS feed from the Flickr.
class Networking {
    
    /// The Flickr url to download the RSS feed.
    static let baseURL = "https://api.flickr.com/services/feeds/photos_public.gne"
    
    /// Enum which defines response queues labels.
    enum ResponseQueueLabels: String {
        case photos = "Photos"
    }
    
    /**
     This function downloads photos from the Flickr.
     - Parameter completion: The completion block which returns PhotosPackage.
     - Parameter response: The reponse which can give optional PhotosPackage.
    */
    func downloadPhotos(_ completion:@escaping (_ response: PhotosPackage?)  -> Void) {
        if let url = URL(string: Networking.baseURL) {
            let queue = DispatchQueue(label: ResponseQueueLabels.photos.rawValue)
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseData(queue: queue, completionHandler: { (response) in
                
                guard let data = response.data else {
                    completion(nil)
                    return
                }
                
                let parser = FeedParser()
                let package = parser.parse(data)
                completion(package)
            })
        }
    }
}
