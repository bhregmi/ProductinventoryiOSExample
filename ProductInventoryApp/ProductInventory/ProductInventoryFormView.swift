//
//  ProductInventoryFormView.swift
//  ProductInventoryApp
//
//  Created by Test User on 5/5/20.
//  Copyright © 2020 Test User. All rights reserved.
//

import SwiftUI

struct ProductInventoryFormView: View {
    
    // to get the customer list
    //    @ObservedObject private var customers = CustomerVM()
    
    
    @ObservedObject private var productInventories = ProductInventoryVM()
    //binding from the
    @Binding var addMode: Bool
    //    @Binding var selectedCustomer: String
    
    
    @State private var customer: String = ""
    @State private var productQuantity: String = ""
    @State private var productName: String = ""
    @State private var productRate: String = ""
    @State private var unloadedBy: String = ""
    @State private var unloadedDate: String = ""
    @State private var isBillable: Bool = false
    @State private var createdOn: String = ""
    
    @State private var isShowingDetailView = false
    
    var body: some View {
        //        NavigationView {
        List {
            ScrollView(.horizontal, showsIndicators: false) {
                VStack {
                    
                    HStack {
                        LabelTextFieldNavigation(label: "Customer Name:", placeHolder: "Customer Name", customerInfo: $customer)
                        NavigationLink(destination: ProductInventoryCustomerListSelectionView(selectedCustomerValue: self.$customer, isShowingDetailView: $isShowingDetailView) //, isActive: $isShowingDetailView
                        )  {
                            Image(systemName: "chevron.compact.right")//.offset(x: -5)
                        }
                    }.offset(x: -5)
                    
                    HStack {
                        LabelTextFieldNavigation(label: "Product Name:", placeHolder: "Product Name", customerInfo: $productName)
                        NavigationLink(destination: ProductInventoryProductNameRateListSelectionView(selectedProductNameRateValue: self.$productName, selectedproductRate: self.$productRate, isShowingDetailView: $isShowingDetailView) //, isActive: $isShowingDetailView
                        ){
                            Image(systemName: "chevron.compact.right")//.offset(x: -5)
                        }
                    }.offset(x: -5)
                    LabelTextField(label: "Product Rate:", placeHolder: "Product Rate", customerInfo: $productRate)
                    LabelTextField(label: "Product Quantity:", placeHolder: "Product Quantity", customerInfo: $productQuantity)
                    LabelTextField(label: "Unloaded Date:", placeHolder: "Unloaded Date", customerInfo: $unloadedDate)
                    LabelCheckBoxField(label: "Is Billable:", isBillable: $isBillable)
                    Button(action: {
                        let productInventoryInfo = ProductInventory(id: nil, productQuantity: Int(self.productQuantity) ?? 0, productNameRate: ProductNameRateFK(id: Int(self.productName)), isBillable: self.isBillable, createdOn: ISO8601DateFormatter().string(from: Date()), unloadedBy: "TestUser", customer: CustomerFK(id: Int(self.customer) ?? 0), unloadedDate: ISO8601DateFormatter().string(from: Date()))
                        
                        self.productInventories.postProductInventory(productInventoryInfo: productInventoryInfo)
                        self.addMode.toggle()
                    }
                    ) {
                        
                        LoginButtonContent()
                    }
                }
            }
        }
        //        }
    }
}


struct ProductInventoryFormView_Previews: PreviewProvider {
    static var previews: some View {
        ProductInventoryFormView(addMode: .constant(false))
    }
}

struct LabelTextFieldNavigation : View {
    
    var label: String
    var placeHolder: String
    @Binding var customerInfo: String
    
    var body: some View {
        HStack {
            Text(label)
                .frame(width: 100, alignment: .leading)
                .font(.system(size: 11, weight: .bold))
            //Spacer()
            TextField(placeHolder, text: $customerInfo)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 180, alignment: .leading)
                .font(.system(size: 11))
        }.padding(.horizontal)
        
    }
}

struct LabelCheckBoxField : View {
    
    var label: String
    @Binding var isBillable: Bool
    
    var body: some View {
        HStack {
            Text(label)
                .frame(width: 100, alignment: .leading)
                .font(.system(size: 11, weight: .bold))
            //Spacer()
            Image(systemName: isBillable ? "checkmark.square" : "square").onTapGesture {
                self.isBillable.toggle()}
        }.offset(x: -90)
    }
}


