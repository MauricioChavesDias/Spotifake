//
//  Product.swift
//  Spotifake
//
//  Created by Mauricio Chaves Dias on 23/4/2024.
//

import Foundation

// MARK: - Welcome
struct Products: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product: Codable, Identifiable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
    
    var firstImage: String {
        images.first ?? Constants.randomImage
    }
    
    static var dummyProduct: Product {
        Product(
            id: 123,
            title: "Example Product Title",
            description: "Some dummy description of the product goes here.",
            price: 99,
            discountPercentage: 11,
            rating: 4.5,
            stock: 50,
            brand: "Apple",
            category: "Eletronic devices",
            thumbnail: Constants.randomImage,
            images: [Constants.randomImage, Constants.randomImage, Constants.randomImage, Constants.randomImage, Constants.randomImage]
        )
    }
}


struct ProductRow: Identifiable {
    let id = UUID().uuidString
    let title: String
    let products: [Product]
}

