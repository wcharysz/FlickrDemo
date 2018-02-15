//
//  ViewController.swift
//  FlickrDemo
//
//  Created by Wojciech Charysz on 08.02.18.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import UIKit
import Koloda

class ViewController: UIViewController, KolodaViewDataSource, KolodaViewDelegate {
    
    @IBOutlet weak var kolodaView: KolodaView!
    
    /// The activity indicator which is launched when you download the new RSS feed.
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var viewModel: ViewModel = {
        return ViewModel(self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewModel.downloadPhotosFeed {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        }
    }


    // MARK: - KolodaViewDataSource
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return viewModel.photosCount
    }

    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return OverlayView()
    }
    
    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let nib = UINib(nibName: "PhotoCard", bundle: Bundle.main)
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? PhotoCard else {
            return UIView()
        }
        
        let photo = viewModel.photosPackage?.photos?[index]
        view.viewModel.photo = photo
        
        return view
    }
    
    // MARK: - KolodaViewDelegate
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        activityIndicator.startAnimating()
        
        viewModel.downloadPhotosFeed {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

