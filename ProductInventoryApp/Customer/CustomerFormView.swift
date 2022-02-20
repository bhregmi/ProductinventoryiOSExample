//
//  CustomerFormView.swift
//  ProductInventoryApp
//
//  Created by Test User on 5/3/20.
//  Copyright © 2020 Test User. All rights reserved.
//

import SwiftUI

struct CustomerFormView: View {
    
    @ObservedObject private var customers = CustomerVM()
//    @State private var customers = CustomerVM()
    //binding from the
    @Binding var addMode: Bool
    
    @State private var customerName: String = ""
    @State private var customerPAN: String = ""
//    @State private var businessName: String = ""
//    @State private var customerAddress: String = ""
//    @State private var customerPhone: String = ""
    @State private var isActive: Bool = true
    
    
    var body: some View {
        List {
            ScrollView(.horizontal, showsIndicators: false) {
                VStack {
                    LabelTextField(label: "Customer Name:", placeHolder: "Customer name", customerInfo: $customerName)
                    
                    HStack {
                        LabelTextField(label: "PAN:", placeHolder: "PAN", customerInfo: $customerPAN)
                        Button(action: { self.customers.panSearch(panNo: self.customerPAN)
                        })
                        {
                            Image(systemName: "magnifyingglass").frame( alignment: .trailing)
                            
                        }
                    }.offset(x: 12)
                
                    LabelTextField(label: "Business Name:", placeHolder: "Business Name", customerInfo: $customers.panData.businessName)
                    LabelTextField(label: "Address:", placeHolder: "Business Address", customerInfo: $customers.panData.cutomerAddress)
                    LabelTextField(label: "Phone:", placeHolder: "Phone", customerInfo: $customers.panData.customerPhone)
                    
                    Button(action: {let customerInfo = Customer(
                        customerPAN: self.customerPAN,
                        businessName: "\(self.customers.panData.businessName)",
                        customerAddress: "\(self.customers.panData.cutomerAddress)",
                        customerName: self.customerName,
                        id: nil,
                        customerPhone: "\(self.customers.panData.customerPhone)",
                        createdOn: ISO8601DateFormatter().string(from: Date()),
                        createdBy: "TestUser",
                        isActive: self.isActive)
                        
                        self.customers.postCustomer(customerInfo: customerInfo)
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

struct CustomerFormView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerFormView(addMode: .constant(false))
    }
}


struct LabelTextField : View {
    
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
                .frame(width: 200, alignment: .leading)
                .font(.system(size: 11))
        }
        
    }
}


struct LoginButtonContent : View {
    var body: some View {
        VStack {
            //Image(systemName: "add")
            Text("Save")
                .font(.headline)
        }
        .padding(.top)
    }
}


