//
//  CalendarCell.swift
//  SwiftUICalendar
//
//  Created by 杨 on 2020/3/17.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import SwiftUI

struct CalendarCell: View {
    @EnvironmentObject var obj : CalendarManager
    
    var holderDate : HolderDate
    
    @State var state : CellState = .normal
    
    enum CellState {
        case normal
        case selected
        case current
        case disabled
        case placeholder
        
        func stateBackColor() -> Color {
            switch self {
            case .normal:
                return .white
            case .selected:
                return .blue
            case .current:
                return .red
            case .disabled:
                return .white
            case .placeholder:
                return .clear
            }
        }

        func stateTextColor() -> Color {
            switch self {
            case .normal:
                return .black
            case .selected:
                return .white
            case .current:
                return .white
            case .disabled:
                return .gray
            case .placeholder:
                return .clear
            }
        }
    }

    var body: some View {
//        Button(action: {
//            self.buttonTap()
//        }) {
//            Text(self.day())
//        }
        Text(self.day())
        .disabled(holderDate.date == nil || isFuture())
        .frame(width: 44, height: 44)
        .foregroundColor(state.stateTextColor())
        .background(state.stateBackColor())
        .clipShape(Circle())
        .onAppear {
            self.stateChanged(animated: false)
        }
        .onReceive(obj.didChangeSelectedDate) { value in
            self.stateChanged()
        }
    }
    
    
    func stateChanged(animated : Bool = true) {
        if let _ = holderDate.date {
            let change =  {
                if self.isToday() {
                    self.state = .current
                } else {
                    self.state = .normal
                }
            }
//            let change =  {
//                if self.isFuture() {
//                    self.state = .disabled
//                } else if self.isSelected() {
//                    self.state = .selected
//                } else if self.isToday() {
//                    self.state = .current
//                } else {
//                    self.state = .normal
//                }
//            }
            if animated {
                withAnimation {
                    change()
                }
            } else {
                change()
            }
        } else {
            self.state = .placeholder
        }
    }
    
    func buttonTap() {
        if let date = self.holderDate.date {
            withAnimation(.spring()) {
                if self.isSelected() {
                    if isToday() {
                        self.state = .current
                    } else {
                        self.state = .normal
                    }
                    self.obj.selectedDate = Date()
                } else {
                    self.obj.selectedDate = date
                }
            }
        }
    }
    
    func day() -> String {
        if let date = holderDate.date {
            let components = obj.calendar.dateComponents([.day], from: date)
            return "\(components.day!)"
        }
        return ""
    }
    
    func isToday() -> Bool {
        if let date = holderDate.date {
            return date.isToday()
        }
        return false
    }
    
    func isFuture() -> Bool {
        if let date = holderDate.date {
            return date.isFuture()
        }
        return false
    }
    
    func isSelected() -> Bool {
        if let date = holderDate.date {
            let selected = obj.selectedDate
            return date.isSameDay(date: selected)
        }
        return false
    }
    
}

struct CalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalendarCell(holderDate: HolderDate(date:Date()))
            .previewDisplayName("Normal")

//            CalendarCell(holderDate: HolderDate(date:Date()), state: .constant(.current))
//            .previewDisplayName("Current")
//
//            CalendarCell(holderDate: HolderDate(date:Date()), state: .constant(.selected))
//            .previewDisplayName("Selected")
//
//            CalendarCell(holderDate: HolderDate(date:Date()), state: .constant(.disabled))
//            .previewDisplayName("Disabled")
        }.previewLayout(.fixed(width: 300, height: 100))
    }
}
