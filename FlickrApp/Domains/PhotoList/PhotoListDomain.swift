//
//  PhotoListDomain.swift
//  FlickrApp
//
//  Created by Wojciech Charysz on 20.10.22.
//

import Foundation
import ComposableArchitecture

struct PhotoList: ReducerProtocol {
    
    enum RouteSteps: Hashable {
        case photoDetails(Photo.State?)
    }
    
    struct State: Equatable {
        @BindingState var photosContainer: [Photo.State] = []
        @BindingState var route: [RouteSteps] = []
    }
    
    @Dependency(\.feedParser.parseFeed) var parser
    @Dependency(\.feedClient.fetchFeed) var fetchFeed
    
    enum Action: BindableAction {
        case loadNewPhotos
        case checkPhotosStack(shownElement: Photo.State)
        case photoDomain(action: Photo.Action)
        case addPhotos(PhotoContainer)
        case binding(BindingAction<State>)
        case navigate(RouteSteps)
    }
    
    var body: some ReducerProtocol<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .loadNewPhotos:
                return .run { send in
                    let data = try await fetchFeed()
                    let parsedResult = try parser(data)
                    await send(.addPhotos(parsedResult), animation: .easeInOut)
                }
            case .addPhotos(let newPhotos):
                state.photosContainer.append(contentsOf: newPhotos.entries)
                return .none
            case .binding:
                return .none
            case .photoDomain(action: _):
                return .none
            case .checkPhotosStack(shownElement: let element):
                if element == state.photosContainer.last {
                    return .task {
                        return .loadNewPhotos
                    }
                }
                
                return .none
            case .navigate( let step):
                state.route = [step]
                return .none
            }
        }
    }
}
