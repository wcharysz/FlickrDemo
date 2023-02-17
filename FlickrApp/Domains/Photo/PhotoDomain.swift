//
//  PhotoDomain.swift
//  FlickrApp
//
//  Created by Wojciech Charysz on 19.10.22.
//

import Foundation
import ComposableArchitecture

struct Photo: ReducerProtocol {

    struct State: Equatable, Identifiable {
        var id = UUID()
        var author: PhotoAuthor
        var photo: PhotoData
    }
    
    enum Action {
        case onAppear
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            }
        }
    }
}
