//
//  ProductInventoryListView.swift
//  ProductInventoryApp
//
//  Created by Test User on 5/5/20.
//  Copyright © 2020 Test User. All rights reserved.
//

import SwiftUI

struct ProductInventoryListView: View {
    
    @ObservedObject private var productInventories = ProductInventoryVM()
      
    var body: some View {

        List{
            ForEach(productInventories.productInventoryList) { productInventory in
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Text("\(productInventory.id!)")
                            Text("Customer Name: \(productInventory.customer.id)").fontWeight(.medium)
                            Text("Product Quantity: \(productInventory.productQuantity)")
                            Text("Product Name: \(productInventory.productNameRate.id!)")
                            Text("Product Rate: \(productInventory.productNameRate.id!)")
                            Text("Unloaded Date: \(productInventory.unloadedDate)")
                            Text("Is Billable: ")
                            Image(systemName: productInventory.isBillable ? "checkmark.square" : "square")
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
            let productInventoryID =  productInventories.productInventoryList[index].id ?? 0
            self.productInventories.deleteProductNameRate(productInventoryID: productInventoryID)
            self.productInventories.productInventoryList.remove(atOffsets: offsets)
        }
    }
}


struct ProductInventoryListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductInventoryListView()
    }
}


struct CheckboxFieldView : View {

    @State var checkState:Bool = false ;

    var body: some View {

         Button(action:
            {
                //1. Save state
                self.checkState = !self.checkState
                print("State : \(self.checkState)")


        }) {
            HStack(alignment: .top, spacing: 10) {

                        //2. Will update according to state
                   Rectangle()
                            .fill(self.checkState ? Color.green : Color.red)
                            .frame(width:20, height:20, alignment: .center)
                            .cornerRadius(5)

                   Text("Todo  item ")

            }
        }
        .foregroundColor(Color.white)

    }

}
