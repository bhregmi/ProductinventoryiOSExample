//
//  ProductNameRateCombineView.swift
//  ProductInventoryApp
//
//  Created by Test User on 5/3/20.
//  Copyright © 2020 Test User. All rights reserved.
//

import SwiftUI

struct ProductNameRateCombineView: View {
    
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
                        ProductNameRateFormView(addMode: $addMode)//.padding(.horizontal).frame(height: 220)
                    }
                    Divider()
                    Divider()
                }
                Text("Product Rate List")
                    .font(.headline)
                    .frame(maxWidth: .infinity, maxHeight: 50.0)
                    .background(Color.yellow)
                Divider()
                Divider()
                
                ProductNameRateListView()
                
            }
            .navigationBarTitle("Product Information").font(.subheadline)
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

struct ProductNameRateCombineView_Previews: PreviewProvider {
    static var previews: some View {
        ProductNameRateCombineView()
    }
}
