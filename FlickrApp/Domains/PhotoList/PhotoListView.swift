//
//  PhotoListView.swift
//  FlickrApp
//
//  Created by Wojciech Charysz on 20.10.22.
//

import SwiftUI
import ComposableArchitecture
import CardStack

struct PhotoListView: View {
    
    let store: Store<PhotoList.State, PhotoList.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            CardStack(direction: LeftRight.direction(degrees:), data: viewStore.binding(\.$photosContainer)) { element, direction in
                
                viewStore.send(.checkPhotosStack(shownElement: element.wrappedValue))
            } content: { element, direction, value in
                IfLetStore(store.scope(state: { _ in
                    element.wrappedValue
                }, action: PhotoList.Action.photoDomain(action: ))) { store in
                    PhotoView(store: store)
                        .background(.white)
                        .border(.gray)
                        .padding()
                        .clipped()
                }
            }.onAppear {
                viewStore.send(.loadNewPhotos)
            }
        }
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static let state = PhotoList.State()
    
    static var previews: some View {
        PhotoListView(store: Store(initialState: state, reducer: PhotoList()))
    }
}
