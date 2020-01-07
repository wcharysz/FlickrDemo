//
//  SceneDelegate.swift
//  FlickrDemo
//
//  Created by Wojciech Charysz on 07.01.20.
//  Copyright © 2020 Wojciech Charysz. All rights reserved.
//

import Foundation
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: HomeView())
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
