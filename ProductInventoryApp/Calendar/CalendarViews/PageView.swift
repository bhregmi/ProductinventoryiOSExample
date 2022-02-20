//
//  PageView.swift
//  SwiftUICalendar
//
//  Created by 杨志远 on 2020/3/21.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import SwiftUI

struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    @ObservedObject var pageManager : PageManager
    
    init(pageManager : PageManager,views: [Page]) {
        self.pageManager = pageManager
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }

    var body: some View {
        PageViewController(controllers: viewControllers, pageManager: pageManager)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pageManager: PageManager(), views: [Color.red,Color.green])
            .aspectRatio(3/2, contentMode: .fit)
    }
}

