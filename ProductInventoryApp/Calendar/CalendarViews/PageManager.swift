//
//  PageManager.swift
//  SwiftUICalendar
//
//  Created by 杨志远 on 2020/3/22.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import SwiftUI
import Combine

class PageManager : ObservableObject {
//    let objectWillChange = PassthroughSubject<Int,Never>()
    
    @Published var currentPage : Int = 0 {
        willSet {
            if newValue >= currentPage {
                direction = .forward
            } else {
                direction = .reverse
            }
            
            objectWillChange.send()
        }
        
        didSet {
            onPageChange?(currentPage,direction)
        }
    }
    
    var direction : UIPageViewController.NavigationDirection = .forward
    /// Bug: Prevent `ObservableObject` not call the updateView of `UIViewControllerRepresentable`
    /// https://stackoverflow.com/questions/58142942/swiftui-not-refresh-my-custom-uiview-with-uiviewrepresentable-observableobject
    var onPageChange: ((Int,UIPageViewController.NavigationDirection)->Void)?
}
