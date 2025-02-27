//
//  SpotifakePlayListHeaderCell.swift
//  Spotifake
//
//  Created by Mauricio Chaves Dias on 7/5/2024.
//

import SwiftUI
import SwiftfulUI

struct PlayListHeaderCell: View {
    
    var height: CGFloat = 300
    var title: String = "Some playlist title goes here"
    var subtitle: String = "Subtitle goes here"
    var imageName: String = Constants.randomImage
    var shadowColor: Color = .spotifakeBlack.opacity(0.8)
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay(
                ImageLoaderView(urlString: imageName)
            )
            .overlay(
                VStack(alignment: .leading, spacing: 8) {
                    Text(subtitle)
                        .font(.headline)
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                    .foregroundColor(.spotifakeWhite)
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(
                            colors: [shadowColor.opacity(0), shadowColor],
                            startPoint: .top,
                            endPoint: .bottom)
                    )
                
                , alignment: .bottomLeading
            )
            .asStretchyHeader(startingHeight: height)
    }
}

#Preview {
    ZStack {
        Color.spotifakeBlack.ignoresSafeArea()
        
        ScrollView {
            PlayListHeaderCell()
        }
    }
    .ignoresSafeArea()
}
