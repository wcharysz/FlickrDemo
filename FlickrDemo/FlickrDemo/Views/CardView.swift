//
//  CardView.swift
//  FlickrDemo
//
//  Created by Wojciech Charysz on 07.01.20.
//  Copyright © 2020 Wojciech Charysz. All rights reserved.
//

import SwiftUI
import Kingfisher

struct CardView: View {
    
    @ObservedObject var model: PhotoCardModel
    @State private var translation: CGSize = .zero
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                VStack(alignment: .center) {
                    KFImage(model.imageURL)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 309)
                    Text(model.photoTitle ?? "No title").padding(.top, 9)
                }
                
                Text(model.publishDateString)
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 9, trailing: 16))
                
                HStack(alignment: .center, spacing: 0) {
                    KFImage(model.buddyIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 64, alignment: .center)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 22) {
                        Text(model.authorName ?? "No Author")
                        Text(model.uri?.absoluteString ?? "No link")
                    }.padding(.leading, 8)
                }.padding(.top, 20)
                
                Spacer()
            }.background(Color.white)
             .cornerRadius(10)
             .shadow(radius: 10)
             .offset(x: translation.width, y: translation.height)
             .rotationEffect(.degrees(Double(translation.width / geo.size.width * 25)), anchor: .bottom)
             .gesture(DragGesture().onChanged({ value in
                 translation = value.translation
             }).onEnded({ value in
                 translation = .zero
             }))
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(model: PhotoCardModel(nil))
    }
}
