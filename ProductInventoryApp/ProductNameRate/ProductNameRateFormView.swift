//
//  ProductNameRateFormView.swift
//  ProductInventoryApp
//
//  Created by Test User on 5/3/20.
//  Copyright © 2020 Test User. All rights reserved.
//

import SwiftUI

struct ProductNameRateFormView: View {

   @ObservedObject private var productNameRates = ProductNameRateVM()
   //binding from the
   @Binding var addMode: Bool
   
   @State private var productName: String = ""
   @State private var productRate: String = ""
   @State private var rateRevisedDate: String = ""
    
    
    
   
   
   var body: some View {
       List {
           ScrollView(.horizontal, showsIndicators: false) {
               VStack {
                    LabelTextField(label: "Product Name:", placeHolder: "Product name", customerInfo: $productName)
                    LabelTextField(label: "Product Rate:", placeHolder: "Product Rate", customerInfo: $productRate)
                    LabelTextField(label: "Rate Revised Date:", placeHolder: "Rate Revised Date", customerInfo: $rateRevisedDate)
                   
                   Button(action: {
                    let productNameRateInfo = ProductNameRate(id: nil, productName: self.productName, createdBy: "TestUser", productRate: Double(self.productRate) ?? 0.00, rateRevisedDate: ISO8601DateFormatter().string(from: Date()), createdOn: ISO8601DateFormatter().string(from: Date()))
                    
                       self.productNameRates.postProductNameRate(productNameRateInfo: productNameRateInfo)
                       self.addMode.toggle()
                   }
                   ) {
                       
                       LoginButtonContent()
                   }
               }
           }
       }
    }
}

struct ProductNameRateFormView_Previews: PreviewProvider {
    static var previews: some View {
        ProductNameRateFormView(addMode: .constant(false))
    }
}

