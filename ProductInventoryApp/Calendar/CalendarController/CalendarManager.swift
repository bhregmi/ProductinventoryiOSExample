//
//  CalendarManager.swift
//  ProductInventoryApp
//
//  Created by Test User on 5/26/20.
//  Copyright © 2020 Test User. All rights reserved.
//

import SwiftUI
import Combine

class CalendarManager : ObservableObject {
    
    let didChangeSelectedDate = PassthroughSubject<Date,Never>()
    
    @Published var calendar : Calendar = .current
    @Published var selectedDate : Date = Date()
        {
        didSet {
            didChangeSelectedDate.send(selectedDate)
        }
    }
    @Published var selectedDates : [Date] = []
    @Published var pageManager = PageManager()
    /// 24 year
    @Published var minDate = Date().addMonth(by: -12 * 10)
    @Published var date : Date = Date()
    @Published var maxDate = Date().addMonth(by: 12 * 10)
    
    
    var months : Int {
        return minDate.monthDiff(to: maxDate)
    }

    var anyCancellable: AnyCancellable? = nil

    /// for nest ObservableObject not work
    ///  https://stackoverflow.com/questions/58406287/how-to-tell-swiftui-views-to-bind-to-nested-observableobjects
    init() {
        anyCancellable = pageManager.objectWillChange.sink(receiveValue: { value in
            self.objectWillChange.send()
        })
    }
}
