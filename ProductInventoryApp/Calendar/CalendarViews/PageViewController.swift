//
//  PageViewController.swift
//  SwiftUICalendar
//
//  Created by 杨志远 on 2020/3/21.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import SwiftUI
import UIKit

struct PageViewController: UIViewControllerRepresentable {
    var controllers: [UIViewController]
    
    @ObservedObject var pageManager : PageManager
    
    var currentPage: Int {
        return pageManager.currentPage
    }
    
    var direction : UIPageViewController.NavigationDirection {
        return pageManager.direction
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        pageViewController.delegate = context.coordinator
        return pageViewController
    }

    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        let coor = context.coordinator
        if coor.last == currentPage {
            return
        }
        pageViewController.setViewControllers([self.controllers[0]], direction: direction, animated: true)
        coor.last = currentPage
    }

    class Coordinator: NSObject, UIPageViewControllerDelegate {
        var parent: PageViewController
        var last : Int = NSNotFound

        init(_ pageViewController: PageViewController) {
            self.parent = pageViewController
        }
    }
}
