//
//  Users.swift
//  Spotifake
//
//  Created by Mauricio Chaves Dias on 23/4/2024.
//

import Foundation

// MARK: - Welcome
struct Users: Codable {
    let users: [User]
    let total, skip, limit: Int
}

// MARK: - User
struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName, maidenName: String
    let age: Int
    let email, phone, username, password: String
    let birthDate: String
    let image: String
    let bloodGroup: String
    let height: Int
    let weight: Double
    
    static var dummyUser = User(
        id: 11,
        firstName: "John",
        lastName: "Doe",
        maidenName: "Smith",
        age: 30,
        email: "john.doe@example.com",
        phone: "+1234567890",
        username: "john_doe",
        password: "securePassword123",
        birthDate: "1994-05-15",
        image: "https://example.com/john_doe.jpg",
        bloodGroup: "O+",
        height: 180,
        weight: 75.0
    )
}


