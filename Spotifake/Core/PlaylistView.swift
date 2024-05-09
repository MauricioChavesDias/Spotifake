//
//  SpotifakePlaylistView.swift
//  Spotifake
//
//  Created by Mauricio Chaves Dias on 7/5/2024.
//

import SwiftUI
import SwiftfulRouting

struct PlaylistView: View {
    
    var product: Product = .dummyProduct
    var user: User = .dummyUser
    
    @Environment(\.router) var router
    
    @State private var products: [Product] = []
    @State private var showHeader: Bool = true
    @State private var offset: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.spotifakeBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    PlayListHeaderCell(
                        height: 250,
                        title: product.title,
                        subtitle: product.brand,
                        imageName: product.thumbnail
                    )
                    .readingFrame { frame in
                        showHeader = frame.maxY < 150
                    }
                    
                    DescriptionCell(
                        descriptionText: product.description,
                        userName: user.firstName,
                        subheadline: product.category,
                        onAddToPlaylistPressed: nil,
                        onDownloadPressed: nil,
                        onEllipsisPressed: nil,
                        onShufflePressed: nil,
                        onPlayPressed: nil
                    )
                    .padding(.horizontal, 16)
                    
                    ForEach(products) { product in
                        SongRowCell(
                            imageSize: 50,
                            imageName: product.firstImage,
                            title: product.title,
                            subtitle: product.brand,
                            onCellPressed: {
                                goToPlaylistView(product: product)
                            },
                            onEllipsisPressed: {
                                
                            }
                        )
                        
                    }
                    .padding(.leading, 16)
                }
            }
            .scrollIndicators(.hidden)
            
            header
                .frame(maxHeight: .infinity, alignment: .top)
            
            
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    
    //MARK: - Views
    
    private var header: some View {
        ZStack() {
            Text(product.title)
                .font(.headline)
                .foregroundStyle(.spotifakeWhite)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .offset(y: showHeader ? 0 : -40)
                .background(.spotifakeBlack)
                .opacity(showHeader ? 1 : 0)
            
            Image(systemName: "chevron.left")
                .font(.title2)
                .padding(10)
                .background(showHeader ? .black.opacity(0.001) : .spotifakeGray.opacity(0.7))
                .clipShape(Circle())
                .onTapGesture {
                    router.dismissScreen()
                }
                .padding(.leading, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .foregroundStyle(.spotifakeWhite)
        .animation(.smooth(duration: 0.2), value: showHeader)
    }
    
    
    //MARK: - Data Usage
    
    private func getData() async {
        do {
            products = try await DatabaseHelper().getProducts()
            
        } catch {
            print(error)
        }
    }
    
    
    //MARK: Routing
    
    private func goToPlaylistView(product: Product) {
        router.showScreen(.push) { _ in
            PlaylistView(product: product, user: user)
        }
    }
}

#Preview {
    RouterView { _ in
        
        PlaylistView()
    }

}
