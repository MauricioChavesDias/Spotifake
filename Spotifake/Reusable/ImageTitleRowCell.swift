//
//  ImageTitleRowCell.swift
//  Spotifake
//
//  Created by Mauricio Chaves Dias on 6/5/2024.
//

import SwiftUI

struct ImageTitleRowCell: View {
    
    var imageName: String = Constants.randomImage
    var imageSize: CGFloat? = 100
    var title: String? = "Some Title"
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            
            if let title {
                Text(title)
                    .foregroundStyle(.spotifakeLightGray)
                    .font(.callout)
                    .padding(4)
                    .lineLimit(2)
            }
        }
        .frame(width: imageSize)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        ImageTitleRowCell(title: "Test dasdsadas dasdadsada")
    }

}
