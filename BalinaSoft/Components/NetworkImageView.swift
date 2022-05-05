//
//  NetworkImageView.swift
//  BalinaSoft
//
//  Created by Artem Kutasevich on 5.05.22.
//

import SwiftUI

import SwiftUI
import SDWebImageSwiftUI

struct NetworkImageView: View {
    let networkImage: NetworkImage
    
    var body: some View {
        ZStack {
            if let imageURL = networkImage.imageURL {
                WebImage(url: URL(string: imageURL))
                    .resizable()
                    .scaledToFill()
            } else {
                Image("placeholder")
                    .resizable()
                    .scaledToFill()
            }
            
            HStack {
                Text(networkImage.imageTitle)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
        }
        .frame(height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct SomeView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkImageView(networkImage: NetworkImage(id: 1, imageTitle: "nn", imageURL: "nn"))
    }
}

