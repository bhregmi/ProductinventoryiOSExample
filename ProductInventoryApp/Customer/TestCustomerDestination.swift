//
//  TestCustomerDestination.swift
//  ProductInventoryApp
//
//  Created by Test User on 5/27/20.
//  Copyright © 2020 Test User. All rights reserved.
//

import SwiftUI

struct TestCustomerDestination: View {
       var body: some View {
           List {
               ScrollView(.horizontal, showsIndicators: false) {
                   VStack {
                        Text("how are you")
               }
           }
        }
    }
}

struct TestCustomerDestination_Previews: PreviewProvider {
    static var previews: some View {
        TestCustomerDestination()
    }
}
