//
//  ViewModel.swift
//  FlickrDemo
//
//  Created by Wojciech Charysz on 08.02.18.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation

/// ViewModel is used together with the ViewController to provide it content.
class ViewModel {
    
    /// The reference to the presented ViewController.
    unowned var viewController: ViewController
    
    init(_ controller: ViewController) {
        viewController = controller
    }
    
    /// The model of the photos container. It provides content for the Koloda view.
    var photosPackage: PhotosPackage? {
        didSet {
            DispatchQueue.main.async {
                self.viewController.kolodaView.resetCurrentCardIndex()
            }
        }
    }
    
    /// The total count of the photos in the photosPackage. It gives 0 when there are no photos.
    var photosCount: Int {
        return photosPackage?.photos?.count ?? 0
    }
    
    /**
     This function downloads the Flickr's RSS XML and converts it into PhotosPackage object. If the xml does not contain required elements it will deliver PhotosPackage with an empty array of Photos or nil.
     - Parameter completion: The completion closure which is called if the download was successful or failed.
    */
    func downloadPhotosFeed(_ completion:@escaping () -> Void) {
        let network = Networking()
        network.downloadPhotos { (package) in
            if let package = package {
                self.photosPackage = package
            }
            completion()
        }
    }
    
}
