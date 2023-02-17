//
//  PhotoView.swift
//  FlickrApp
//
//  Created by Wojciech Charysz on 19.10.22.
//

import SwiftUI
import ComposableArchitecture

struct PhotoView: View {
    
    let store: Store<Photo.State, Photo.Action>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ScrollView {
                VStack {
                    AsyncImage(url: viewStore.photo.imageURL) { image in
                        image.resizable().aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView().padding()
                    }.padding(.bottom)

                    Divider()
                    
                    HStack(alignment: .center) {
                        Text(viewStore.photo.title ?? "No title").bold().padding()
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Published:")
                            Text(viewStore.photo.publishDate ?? Date(), style: .date)
                            Spacer()
                        }.padding()
                    }
                    
                    Divider()
                    
                    HStack(alignment: .center) {
                        AsyncImage(url: viewStore.author.buddyIcon) { image in
                            image.resizable().aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }.frame(maxHeight: 64)
                            .shadow(radius: 10)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                            .padding()
                        
                        VStack(alignment: .leading) {
                            Text(viewStore.author.name ?? "No name")
                            
                            if let uri = viewStore.author.uri {
                                Link("Author site", destination: uri)
                            } else {
                                EmptyView()
                            }
                        }.padding()

                        Spacer()
                    }.padding()
                    
                    Divider()
                }
            }
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static let state = Photo.State(author: PhotoAuthor(name: "neil grandison", buddyIcon: URL(string: "https://farm6.staticflickr.com/5481/buddyicons/40682380@N06.jpg?1399987089#40682380@N06"), uri: URL(string: "https://www.flickr.com/people/neil_gr/")), photo: PhotoData(title: "IMG_4600", publishDate: Date(), imageURL: URL(string: "https://farm5.staticflickr.com/4768/25297525777_0070c287f7_b.jpg")))
    
    static var previews: some View {
        PhotoView(store: Store(initialState: state, reducer: Photo()))
    }
}
