//
//  KolodaViewExtension.swift
//  FlickrDemo
//
//  Created by Wojciech Charysz on 08.02.18.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation
import Koloda

/**
This extension enables connecting outlets for KolodaViewDelegate and KoloadaViewDataSource in the Interface Builder.
 */
extension KolodaView {
    
    /// This is a property to connect outlet in the Interface Builder conforming KolodaViewDelegate protocol.
    @IBOutlet weak var koladaDelegate: AnyObject? {
        get {
            return delegate
        }
        
        set {
            delegate = newValue as? KolodaViewDelegate
        }
    }
    
    /// This is a property to connect outlet in the Interface Builder conforming KoloadaViewDataSource protocol.
    @IBOutlet weak var koladaDataSource: AnyObject? {
        get {
            return dataSource
        }
        
        set {
            dataSource = newValue as? KolodaViewDataSource
        }
    }
}
