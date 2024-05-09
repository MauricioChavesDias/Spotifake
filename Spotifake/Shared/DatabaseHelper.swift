//
//  DatabaseHelper.swift
//  Spotifake
//
//  Created by Mauricio Chaves Dias on 21/4/2024.
//

import Foundation

struct DatabaseHelper {
    
    func getProducts() async throws -> [Product] {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            throw URLError(.badURL)
        }
        let session = URLSession(configuration: .default, delegate: CustomDelegate(), delegateQueue: nil)

        let (data, _ ) = try await session.data(from: url)
        let products = try JSONDecoder().decode(Products.self, from: data)
        
        return products.products
    }
    
    func getUsers() async throws -> [User] {
        guard let url = URL(string: "https://dummyjson.com/users") else {
            throw URLError(.badURL)
        }
        let session = URLSession(configuration: .default, delegate: CustomDelegate(), delegateQueue: nil)

        let (data, _ ) = try await session.data(from: url)
        let users = try JSONDecoder().decode(Users.self, from: data)
        
        return users.users
    }
}
