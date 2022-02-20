//
//  LoginUser.swift
//  RMISBankPortal
//
//  Created by Test User on 12/21/19.
//  Copyright © 2019 Test User. All rights reserved.
//

import Foundation

// MARK: - LoginUser
struct LoginUser: Codable {
    var username: String
    var password: String
}

// MARK: - Message
struct Message: Codable, Identifiable, Hashable {
    let id: Int?
    let message: String
}

// MARK: - UserResponse
struct UserResponse: Codable {
    let token: String
    let user: User
}

// MARK: - User
struct User: Codable {
    let username: String
}
