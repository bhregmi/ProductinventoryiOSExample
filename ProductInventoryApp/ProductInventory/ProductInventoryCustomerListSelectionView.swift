//
//  ProductInventoryCustomerListSelectionView.swift
//  ProductInventoryApp
//
//  Created by Test User on 5/18/20.
//  Copyright © 2020 Test User. All rights reserved.
//

import SwiftUI

struct ProductInventoryCustomerListSelectionView: View {
    
        @ObservedObject private var customers = CustomerVM()
        @State var selectedCustomer: String? = nil
        @Binding var selectedCustomerValue: String
        @Binding var isShowingDetailView: Bool
        
        
        
        var body: some View {

            List{
                ForEach(customers.customerList) { customer in
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                SelectionCellCustomer(customer: "\(customer.id!)", selectedCustomer: self.$selectedCustomer, selectedCustomerValue: self.$selectedCustomerValue, isShowingDetailView: self.$isShowingDetailView)
    //                            Text("\(customer.id!)")
                                Text("Name: \(customer.customerName)").fontWeight(.medium)
                                Text("PAN: \(customer.customerPAN)")
                                Text("Business: \(customer.businessName)")
                                Text("Address: \(customer.customerAddress)")
                                Text("Phone: \(customer.customerPhone)")
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
struct SelectionCellCustomer: View {

    let customer: String
    @Binding var selectedCustomer: String?
    @Binding var selectedCustomerValue: String
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
                // For check mark
                self.selectedCustomer = self.customer
                // To pass value to parent view
                self.selectedCustomerValue = self.customer
                self.isShowingDetailView = false
            }
    }
}

struct ProductInventoryCustomerListSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ProductInventoryCustomerListSelectionView(selectedCustomerValue: .constant(""), isShowingDetailView: .constant(true))
    }
}
