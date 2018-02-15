//
//  UIViewExtensions.swift
//  FlickrDemo
//
//  Created by Wojciech Charysz on 12.02.18.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// This property enables setting a corner radius of the UIView layer directly in the Interface Builder
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
        }
    }
    
    /// This property enables setting a colour of the UIView layer border directly in the Interface Builder
    @IBInspectable var borderIBColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        
        get {
            if let colour = layer.borderColor {
                return UIColor(cgColor: colour)
            }
            
            return nil
        }
    }
    
    @IBInspectable var borderIBWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        
        get {
            return layer.borderWidth
        }
    }
}
