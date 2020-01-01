//
//  ContentView.swift
//  Project6
//
//  Created by clarknt on 2019-10-24.
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

struct ContentView: View {
    private let animations: [NamedView] = [
        NamedView("Implicit animation", view: ImplicitAnimation()),
        NamedView("Custom animation", view: CustomAnimation()),
        NamedView("Bindings animation", view: BindingsAnimation()),
        NamedView("Explicit animation", view: ExplicitAnimation()),
        NamedView("Animation stack", view: AnimationStack()),
        NamedView("Animated gestures - 1", view: AnimatedGestures1()),
        NamedView("Animated gestures - 2", view: AnimatedGestures2()),
        NamedView("Show/hide view animation", view: ShowHideViewAnimation()),
        NamedView("Custom transition", view: CustomTransition())
    ]

    var body: some View {
        NavigationView {
            List(0..<animations.count) { i in
                NavigationLink(destination: self.animations[i].view) {
                    Text(self.animations[i].name)
                }
            }
            .navigationBarTitle("Animations")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
