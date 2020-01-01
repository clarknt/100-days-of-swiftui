//
//  MainView.swift
//  Project15-Challenge3
//
//  Created by clarknt on 2019-11-01.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct NamedView {
    var name: String
    var view: AnyView

    init<V>(_ name: String, view: V) where V: View {
        self.name = name
        self.view = AnyView(view)
    }
}

struct MainView: View {
    private let topics: [NamedView] = [
        NamedView("Resizing images to fit the screen using GeometryReader", view: ResizeImage()),
    NamedView("How ScrollView lets us work with scrolling data", view: Scrolling()),
    NamedView("Pushing new views onto the stack using NavigationLink", view: PushingViews()),
    NamedView("Working with hierarchical Codable data", view: HierarchyCodable()),

    ]

    var body: some View {
        NavigationView {
            List(0..<topics.count) { i in
                NavigationLink(destination: self.topics[i].view) {
                    Text(self.topics[i].name)
                }
            }
            .navigationBarTitle("Topics")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
