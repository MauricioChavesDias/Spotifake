//
//  SpotifakeSongRowCell.swift
//  Spotifake
//
//  Created by Mauricio Chaves Dias on 7/5/2024.
//

import SwiftUI
import SwiftfulUI

struct SongRowCell: View {
    
    var imageSize: CGFloat = 60
    var imageName: String = Constants.randomImage
    var title: String = "Title Songdsadsa"
    var subtitle: String = "Here goes the subtitle of the song."
    
    var onCellPressed: (() -> Void)? = nil
    var onEllipsisPressed: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            HStack(alignment: .top, spacing: 8) {
                ImageLoaderView(urlString: imageName)
                    .frame(width: imageSize,height: imageSize)
                
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundStyle(.spotifakeWhite)
                    
                    Text(subtitle)
                        .font(.callout)
                        .foregroundStyle(.spotifakeLightGray)
                }
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Image(systemName: "ellipsis")
                .font(.subheadline)
                .foregroundColor(.spotifakeWhite)
                .padding(16)
                .background(.black.opacity(0.001))
                .asButton(.press) {
                   onEllipsisPressed?()
                }
        }
        .asButton {
            onCellPressed?()
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack {
            SongRowCell()
            SongRowCell()
            SongRowCell()
            SongRowCell()
            
        }
    }
}
