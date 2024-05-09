//
//  SpotifakeCategoryCell.swift
//  Spotifake
//
//  Created by Mauricio Chaves Dias on 6/5/2024.
//

import SwiftUI

struct CategoryCell: View {
    
    var title: String = "All"
    var isSelected: Bool = false
    
    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 35)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .themeColors(isSelected: isSelected)
            .cornerRadius(16)
    }
}

extension View {
    
    func themeColors(isSelected: Bool) -> some View {
        self
            .background(isSelected ? .spotifakeGreen : .spotifakeDarkGray)
            .foregroundStyle(isSelected ? .spotifakeBlack : .spotifakeWhite)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        HStack(spacing: 40) {
            CategoryCell()
            CategoryCell(title: "Podcasts", isSelected:  true)
            CategoryCell(title: "Classic", isSelected: false)
        }

    }

}
