//
//  FlickrAppApp.swift
//  FlickrApp
//
//  Created by Wojciech Charysz on 19.10.22.
//

import SwiftUI
import ComposableArchitecture

@main
struct FlickrAppApp: App {
    var body: some Scene {
        WindowGroup {
            PhotoListView(store: Store(initialState: PhotoList.State(), reducer: PhotoList()))
        }
    }
}
