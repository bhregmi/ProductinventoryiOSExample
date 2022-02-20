//
//  ProductInventory.swift
//  ProductInventoryApp
//
//  Created by Test User on 5/5/20.
//  Copyright © 2020 Test User. All rights reserved.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productInventory = try? newJSONDecoder().decode(ProductInventory.self, from: jsonData)

import Foundation

// MARK: - ProductInventory
struct ProductInventory: Codable, Identifiable {
    let id: Int?
    let productQuantity: Int
    let productNameRate: ProductNameRateFK
    let isBillable: Bool
    let createdOn: String //Date
    let unloadedBy: String
    let customer: CustomerFK
    let unloadedDate: String //Date
}

// MARK: - Customer
struct CustomerFK: Codable {
    let id: Int
}

// MARK: - ProductNameRate
struct ProductNameRateFK: Codable {
    let id: Int?
}
