//
//  ProductNameRate.swift
//  ProductInventoryApp
//
//  Created by Test User on 5/3/20.
//  Copyright © 2020 Test User. All rights reserved.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productNameRate = try? newJSONDecoder().decode(ProductNameRate.self, from: jsonData)

import Foundation

// MARK: - ProductNameRate
struct ProductNameRate: Codable, Identifiable {
    let id: Int?
    let productName, createdBy: String
    let productRate: Double
    let rateRevisedDate, createdOn: String //Date
}

