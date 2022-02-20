//
//  MockData.swift
//  ProductInventoryApp
//
//  Created by Test User on 4/29/20.
//  Copyright © 2020 Test User. All rights reserved.
//

import Foundation

let customerInfoJsonData = """
[
    {
        "customerPAN": "999888777A",
        "customerAddress": "China",
        "customerName": "Pattu1111",
        "id": 1,
        "customerPhone": "9876543210",
        "createdOn": "2020-04-28T17:14:51Z",
        "createdBy": "testuser"
    },
    {
        "customerPAN": "999888777A",
        "customerAddress": "China",
        "customerName": "Pattu1111",
        "id": 2,
        "customerPhone": "9876543210",
        "createdOn": "2020-04-28T17:14:52Z",
        "createdBy": "testuser"
    }
]
""".data(using: .utf8)


let customerInfoJsonData2 = """
[
    {
        "customerPAN": "999888777A",
        "customerAddress": "China",
        "customerName": "Pattu1111",
        "id": 1,
        "customerPhone": "9876543210",
        "createdOn": "2020-04-28T17:14:51Z",
        "createdBy": "testuser"
    },
    {
        "customerPAN": "999888777A",
        "customerAddress": "China",
        "customerName": "Pattu1111",
        "id": 2,
        "customerPhone": "9876543210",
        "createdOn": "2020-04-28T17:14:52Z",
        "createdBy": "testuser"
    }
]
"""

let panInfoJsonData = """
{"id": 1, "PAN no": 123456789, "Business Name": "Mike Dairy Store", "Address": "New York", "Phone": 987654321}
""".data(using: .utf8)!




