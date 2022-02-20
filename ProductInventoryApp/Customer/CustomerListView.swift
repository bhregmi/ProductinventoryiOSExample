//
//  CustomerListView.swift
//  ProductInventoryApp
//
//  Created by Test User on 4/29/20.
//  Copyright © 2020 Test User. All rights reserved.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct CustomerListView: View {
    
    @ObservedObject private var customers = CustomerVM()
    
    var body: some View {

        List{
            ForEach(customers.customerList) { customer in
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Text("\(customer.id!)")
                            Text("Name: \(customer.customerName)").fontWeight(.medium)
                            Text("PAN: \(customer.customerPAN)")
                            Text("Business: \(customer.businessName)")
                            Text("Address: \(customer.customerAddress)")
                            Text("Phone: \(customer.customerPhone)")
                            Image(systemName: customer.isActive ? "checkmark.square" : "square")
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
            let customerID =  customers.customerList[index].id ?? 0
            self.customers.deleteCustomer(customerID: customerID)
            self.customers.customerList.remove(atOffsets: offsets)
        }
    }
}

struct CustomerListView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerListView()
    }
}


