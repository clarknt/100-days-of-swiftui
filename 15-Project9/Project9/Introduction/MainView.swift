//
//  MainView.swift
//  Project9
//
//  Created by clarknt on 2019-11-06.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

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
        NamedView("Creating custom paths with SwiftUI", view: CustomPaths()),
        NamedView("Paths vs shapes in SwiftUI", view: PathsVsShapes()),
        NamedView("Adding strokeBorder() support with InsettableShape", view: StrokeBorderSupport()),
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
