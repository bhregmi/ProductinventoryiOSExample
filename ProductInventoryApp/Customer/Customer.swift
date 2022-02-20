//
//  Customer.swift
//  ProductInventoryApp
//
//  Created by Test User on 4/29/20.
//  Copyright © 2020 Test User. All rights reserved.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Customer.self, from: jsonData)

import Foundation

// MARK: - Customer
struct Customer: Codable, Identifiable {
    let customerPAN, businessName, customerAddress, customerName: String
    let id: Int?
    let customerPhone: String
    let createdOn: String //Date
    let createdBy: String
    let isActive: Bool
}


// MARK: - PanModel
struct PanModel: Codable {
    var panNo: String
    var businessName: String
    var cutomerAddress: String
    var customerPhone: String
    
    enum CodingKeys: String, CodingKey {
        case panNo = "customerPAN"
        case businessName = "businessName"
        case cutomerAddress = "customerAddress"
        case customerPhone = "customerPhone"
    }
}
