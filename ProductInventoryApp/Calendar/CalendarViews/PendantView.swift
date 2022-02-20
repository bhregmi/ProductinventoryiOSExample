//
//  PendantView.swift
//  CalendarView
//
//  Created by 杨 on 2020/3/17.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import SwiftUI

struct PendantView: View {
    
    @EnvironmentObject var obj : CalendarManager
    
    var components : DateComponents {
        return obj.calendar.dateComponents([.year,.month,.day], from: obj.date)
    }
    
    var month : Int {
        return components.month!
    }

    var color : Color = .green
    
    var body: some View {
        ZStack(alignment: .top) {
            ZStack {
                Rectangle()
                VStack {
                    Text("Mon")
                        .font(.footnote)
                    Text("\(month)")
                }.foregroundColor(Color.white)
            }
            .frame(width: 50, height: 50)
            .cornerRadius(6)
            
            PendantLegView()
            .frame(width: 30)
            .offset(x: 0, y: -8)
        }.foregroundColor(color)
    }
}


struct PendantLegView : View {
    
    var legJoinColor : Color = .white
    
    var legWidth : CGFloat = 5
    var legHeight : CGFloat = 15
    var legJoinHeight : CGFloat = 5
    
    var body: some View {
        HStack {
            ZStack(alignment: .bottom) {
                Capsule()
                    .frame(width: legWidth, height: legHeight)
                Capsule()
                    .frame(width: legWidth, height: legJoinHeight)
                    .foregroundColor(self.legJoinColor)
            }
            
            Spacer()
            
            ZStack(alignment: .bottom) {
                Capsule()
                    .frame(width: legWidth, height: legHeight)
                Capsule()
                    .frame(width: legWidth, height: legJoinHeight)
                    .foregroundColor(self.legJoinColor)
            }
        }
    }
}


struct PendantView_Previews: PreviewProvider {
    static var previews: some View {
        PendantView()
    }
}

struct PendantLegView_Previews: PreviewProvider {
    static var previews: some View {
        PendantLegView().background(Color.green)
    }
}
