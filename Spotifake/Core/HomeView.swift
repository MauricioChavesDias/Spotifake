//
//  SpotifakeHomeView.swift
//  Spotifake
//
//  Created by Mauricio Chaves Dias on 6/5/2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting


//MVVM Approach:
@Observable
final class HomeViewModel {
    let router: AnyRouter
    
    var currentUser: User? = nil
    var selectedCategory: Category? = nil
    var products: [Product] = []
    var productRows: [ProductRow] = []
    
    init(router: AnyRouter) {
        self.router = router
        self.currentUser = currentUser
        self.selectedCategory = selectedCategory
        self.products = products
        self.productRows = productRows
    }
    
    
    //MARK: - Data Usage
    
    func getData() async {
        guard products.isEmpty else { return }
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await Array(DatabaseHelper().getProducts().prefix(8))
            
            var rows: [ProductRow] = []
            
            let allBrands = Set(products.map { $0.brand }) // "Set" avoid having duplicates from the same value in a array
            
            for brand in allBrands {
                //let products = self.products.filter( {$0.brand == brand})
                rows.append(ProductRow(title: brand.capitalized, products: products))
            }
            productRows = rows
            
        } catch {
            print(error)
        }
    }
}

struct HomeView: View {
    
    @State var viewModel: HomeViewModel
    
//    @Environment(\.router) var router
//    
//    @State private var currentUser: User? = nil
//    @State private var selectedCategory: Category? = nil
//    @State private var products: [Product] = []
//    @State private var productRows: [ProductRow] = []
    
    var body: some View {
        ZStack {
            Color.spotifakeBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                VStack(spacing: 16) {
                    
                    recentSection
                    
                    if let safeProduct = viewModel.products.first {
                        newReleaseSection(product: safeProduct)
                            .padding(.horizontal, 16)
                    }
                    
                    listRows
                }
            }
            .scrollIndicators(.hidden)
            .clipped() //hide the cells showing at the top header.
        }
        .task {
            await viewModel.getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    
    //MARK: Views
    
    private var header: some View {
        HStack(spacing: 0) {
            ZStack {
                if viewModel.currentUser != nil {
                    ImageLoaderView()
                        .frame(width: 35, height: 35)
                        .background(.spotifakeWhite)
                        .clipShape(Circle())
                        .onTapGesture {
                            viewModel.router.dismissScreen()
                        }
                }
            }
            .frame(width: 35, height: 35)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(Category.allCases, id: \.self) { category in
                        CategoryCell(
                            title: category.rawValue.capitalized,
                            isSelected: category == viewModel.selectedCategory
                        )
                        .onTapGesture {
                            viewModel.selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .background(Color.spotifakeBlack)
    }
    
    private var recentSection: some View {
        LazyVStack(spacing: 1,
                   pinnedViews: [.sectionHeaders]) {
            Section {
                NonLazyVGrid(columns: 2,
                             alignment: .center,
                             spacing: 16,
                             items: viewModel.products) { product in
                    if let safeProduct = product {
                        RecentsCell(
                            imageName: safeProduct.firstImage,
                            title: safeProduct.title
                        )
                        .asButton(.press) {
                            goToPlaylistView(product: safeProduct)
                        }
                        
                    }
                }
            } header: {
                header
            }
        }
        .padding(.top, 8)
    }
    
    private var listRows: some View {
        ForEach(viewModel.productRows) { row in
            VStack(spacing: 8) {
                Text(row.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.spotifakeWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 12) {
                        ForEach(row.products) { product in
                            ImageTitleRowCell(
                                imageName: product.firstImage,
                                imageSize: 120,
                                title: product.title)
                            .cornerRadius(5)
                            .asButton(.press) {
                                goToPlaylistView(product: product)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
    
    
    //MARK: Routing
    
    private func goToPlaylistView(product: Product) {
        guard let currentUser = viewModel.currentUser else { return }
        
        viewModel.router.showScreen(.push) { _ in
            PlaylistView(product: product, user: currentUser)
        }
    }
    
    
    //MARK: View functions
    
    private func newReleaseSection(product: Product) -> some View {
        NewReleaseCell(
            imageName: product.firstImage,
            headline: product.brand,
            subheadline: product.category,
            title: product.title,
            subtitle: product.description,
            onAddToPlaylistPressed: {
                print("onAddToPlaylistPressed")
            },
            onPlayPressed: {
                print("onPlayPressed")
            }
        )
    }
    
}

#Preview {
    RouterView { router in
        HomeView(viewModel: HomeViewModel(router: router))
    }
}
