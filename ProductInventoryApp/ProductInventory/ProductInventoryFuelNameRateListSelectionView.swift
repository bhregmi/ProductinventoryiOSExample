//
//  ProductInventoryProductNameRateListSelectionView.swift
//  ProductInventoryApp
//
//  Created by Test User on 5/18/20.
//  Copyright © 2020 Test User. All rights reserved.
//

import SwiftUI

struct ProductInventoryProductNameRateListSelectionView: View {
        @ObservedObject private var productNameRates = ProductNameRateVM()
        @State var selectedProductNameRate: String? = nil
        @Binding var selectedProductNameRateValue: String
        @Binding var selectedproductRate: String
        @Binding var isShowingDetailView: Bool
    
    
    var body: some View {

        List{
            ForEach(productNameRates.productNameRateList) { productNameRate in
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            SelectionCellFuleNameRate(customer: "\(productNameRate.id!)", productRate: "\(productNameRate.productRate)", selectedCustomer: self.$selectedProductNameRate, selectedCustomerValue: self.$selectedProductNameRateValue,
                                selectedproductRate: self.$selectedproductRate,
                                isShowingDetailView: self.$isShowingDetailView)
                            
                            
//                            Text("\(productNameRate.id!)")
                            Text("Product Name: \(productNameRate.productName)").fontWeight(.medium)
                            Text("Product Rate: ₹ \(productNameRate.productRate, specifier: "%.2f")")
                            Text("Rate Revised Date: \(productNameRate.rateRevisedDate)")
                        }
                        .font(.system(size: 12))
                        .foregroundColor(Color.gray)
                    }
                }
            }
        }
    }
}

// For check mark selection view
struct SelectionCellFuleNameRate: View {

    let customer: String
    let productRate: String
    @Binding var selectedCustomer: String?
    @Binding var selectedCustomerValue: String
    @Binding var selectedproductRate: String
    @Binding var isShowingDetailView: Bool
    var body: some View {
        HStack {
          VStack {
            if customer == selectedCustomer {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
            }
            VStack {
            Text(customer)
            }//.offset(x: 50)
        }   .onTapGesture {
                self.selectedCustomer = self.customer
            
                self.selectedCustomerValue = self.customer
                self.selectedproductRate = self.productRate
                self.isShowingDetailView = false
            }
    }
}

struct ProductInventoryProductNameRateListSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ProductInventoryProductNameRateListSelectionView(selectedProductNameRateValue: .constant(""), selectedproductRate: .constant(""), isShowingDetailView: .constant(true))
    }
}
