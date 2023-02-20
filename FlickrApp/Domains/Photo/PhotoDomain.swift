//
//  PhotoDomain.swift
//  FlickrApp
//
//  Created by Wojciech Charysz on 19.10.22.
//

import Foundation
import ComposableArchitecture

struct Photo: ReducerProtocol {

    struct State: Equatable, Identifiable, Hashable {
        var id = UUID()
        var author: PhotoAuthor
        var photo: PhotoData
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
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
