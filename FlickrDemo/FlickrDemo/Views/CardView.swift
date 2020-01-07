//
//  CardView.swift
//  FlickrDemo
//
//  Created by Wojciech Charysz on 07.01.20.
//  Copyright © 2020 Wojciech Charysz. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    var image: Image
    
    var body: some View {
        VStack(alignment: .leading) {
            image.frame(height: 310, alignment: .leading)
                .alignmentGuide(.top) { (dimension) -> CGFloat in
                return 0
            }.alignmentGuide(.leading) { (dimension) -> CGFloat in
                return 0
            }.alignmentGuide(.trailing) { (dimension) -> CGFloat in
                return 0
            }
            
            Spacer()
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(image: Image("turtlerock"))
    }
}
