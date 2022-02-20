//
//  SegmentControlMenu.swift
//  SwiftUICalendar
//
//  Created by 杨志远 on 2020/3/22.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import SwiftUI

extension HorizontalAlignment {
    enum HorizontalCenterAlignment : AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.center]
        }
    }
    
    static let horizontalCenter = HorizontalAlignment(HorizontalCenterAlignment.self)
}

struct SegmentControlMenu: View {
    
    @State var selectedIndex : Int = 0
    
    let days = ["Monday", "Tuesday", "Wednesday"]
    
    var body: some View {
        VStack(alignment: .horizontalCenter) {
            HStack {
                ForEach(days.indices,id: \.self) { index in
                    Group {
                        if index == self.selectedIndex {
                            Button(action: {
                                withAnimation {
                                    self.selectedIndex = index
                                }
                            }) {
                                Text(self.days[index])
                            }
                            
                            .alignmentGuide(.horizontalCenter) { d in
                                d[HorizontalAlignment.center]
                            }
                        } else {
                            Button(action: {
                                withAnimation {
                                    self.selectedIndex = index
                                }
                            }) {
                                Text(self.days[index])
                            }
                        }
                    }
                }
            }
            
            Capsule()
            .frame(width: 30, height: 5)
        }
    }
}

struct SegmentControlMenu_Previews: PreviewProvider {
    static var previews: some View {
        SegmentControlMenu()
    }
}
