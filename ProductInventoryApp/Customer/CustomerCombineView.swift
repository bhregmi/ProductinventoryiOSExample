//
//  CustomerCombineView.swift
//  ProductInventoryApp
//
//  Created by Test User on 5/3/20.
//  Copyright © 2020 Test User. All rights reserved.
//

import SwiftUI

struct CustomerCombineView: View {
    
    //    @ObservedObject var customers = CustomerVM()
    //    //    @EnvironmentObject var customers = CustomerVM()
    @State private var editMode = EditMode.inactive
    @State private var addMode = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                Divider()
                if addMode {
                    VStack {
                        CustomerFormView(addMode: $addMode)//.padding(.horizontal).frame(height: 220)
                    }
                    Divider()
                    Divider()
                }
                Text("Customer List")
                    .font(.headline)
                    .frame(maxWidth: .infinity, maxHeight: 50.0)
                    .background(Color.yellow)
                Divider()
                Divider()
                
                CustomerListView()
                
            }
            .navigationBarTitle("Customer Information").font(.subheadline)
            .navigationBarItems(leading: EditButton(), trailing: addButton)
            .environment(\.editMode, $editMode)
        }
    }
    
    private var addButton: some View {
        switch editMode {
        case .inactive:
            //return AnyView(Button(action: onAdd) { Image(systemName: "plus") })
            return AnyView(Button(action: {self.addMode.toggle()}){ Image(systemName: "plus") })
        default:
            return AnyView(EmptyView())
        }
    }
}

struct CustomerCombineView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerCombineView()
    }
}
