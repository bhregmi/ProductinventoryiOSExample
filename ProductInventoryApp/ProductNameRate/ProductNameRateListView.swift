//
//  ProductNameRateListView.swift
//  ProductInventoryApp
//
//  Created by Test User on 5/3/20.
//  Copyright © 2020 Test User. All rights reserved.
//


import SwiftUI

struct ProductNameRateListView: View {
    
    @ObservedObject private var productNameRates = ProductNameRateVM()
    
    var body: some View {

        List{
            ForEach(productNameRates.productNameRateList) { productNameRate in
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Text("\(productNameRate.id!)")
                            Text("Product Name: \(productNameRate.productName)").fontWeight(.medium)
                            Text("Product Rate: ₹ \(productNameRate.productRate, specifier: "%.2f")")
                            Text("Rate Revised Date: \(productNameRate.rateRevisedDate)")
                        }
                        .font(.system(size: 12))
                        .foregroundColor(Color.gray)
                    }
                }
            }
            .onDelete(perform: self.deleteItem)
        }
    }
    
    
    private func deleteItem(at offsets: IndexSet) {
        //        self.customers.customerList.remove(atOffsets: indexSet)
        //        self.customers.deleteCustomer(offsets: indexSet)
        
        for index in offsets {
            //            let user =  session.deleteData(id: customers.customerList[index].id)
            let productNameRateID =  productNameRates.productNameRateList[index].id ?? 0
            self.productNameRates.deleteProductNameRate(productNameRateID: productNameRateID)
            self.productNameRates.productNameRateList.remove(atOffsets: offsets)
        }
    }
}

struct ProductNameRateListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductNameRateListView()
    }
}
