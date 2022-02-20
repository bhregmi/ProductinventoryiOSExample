//
//  LandingPageView.swift
//  ProductInventoryApp
//
//  Created by Test User on 7/4/20.
//  Copyright © 2020 Test User. All rights reserved.
//

import SwiftUI

struct LandingPageView: View {
    
    @State var showMenu = false
    var calendarObj = CalendarManager()
    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
        }
        
        return NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    //                    MainFrontView(showMenu: self.$showMenu)
                    CalendarView().environmentObject(self.calendarObj)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                        .disabled(self.showMenu ? true : false)
                    if self.showMenu {
                        SideMenuView()
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                }
                .gesture(drag)
            }
            .navigationBarTitle("Inventory Management System", displayMode: .inline)
            .navigationBarItems(leading: (
                Button(action: {
                    withAnimation {
                        self.showMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                }
            ))
        }
    }
}

struct MainFrontView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.showMenu = true
            }
        }) {
            Text("Show Menu")
            
        }
    }
}

struct SideMenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(destination: ProductInventoryCombineView() ){
                MenuViewLabel(imageName: "cart", label: "Inventory")
            }
            .padding(.top, 100)
            NavigationLink(destination: CustomerCombineView() ){
                MenuViewLabel(imageName: "person", label: "Customers")
            }
            .padding(.top, 30)
            NavigationLink(destination: ProductNameRateCombineView() ){
                MenuViewLabel(imageName: "gift", label: "Products")
            }
            .padding(.top, 30)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)
    }
}

struct MenuViewLabel: View {
    var imageName: String
    var label: String
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.gray)
                .imageScale(.large)
            Text(label)
                .foregroundColor(.gray)
                .font(.headline)
        }
    }
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}
