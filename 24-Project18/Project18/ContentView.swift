//
//  ContentView.swift
//  Project18
//
//  Created by clarknt on 2020-01-09.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

enum Topics {
    case none, layout, alignment, customAlignment, absolutePositioning, framesAndCoordinates, scrollViewEffect
}

struct ContentView: View {
    @State private var topic: Topics = .none

    var body: some View {
        getCurrentView()
    }

    func getCurrentView() -> some View {
        switch topic {
        case .none:
            return AnyView(getMainView())
        case .layout:
            return AnyView(Intro01Layout(topic: $topic))
        case .alignment:
            return AnyView(Intro02Alignment(topic: $topic))
        case .customAlignment:
            return AnyView(Intro03CustomAlignment(topic: $topic))
        case .absolutePositioning:
            return AnyView(Intro04AbsolutePositioning(topic: $topic))
        case .framesAndCoordinates:
            return AnyView(Intro05FramesAndCoordinates(topic: $topic))
        case .scrollViewEffect:
            return AnyView(Intro06ScrollViewEffect(topic: $topic))
        }
    }

    func getMainView() -> some View {
        NavigationView {
            VStack {
                Text("Note: double tap to go back")
                    .padding()

                List {
                    Button("How layout works in SwiftUI") { self.topic = .layout }
                    Button("Alignment and alignment guides") { self.topic = .alignment }
                    Button("How to create a custom alignment guide") { self.topic = .customAlignment }
                    Button("Absolute positioning for SwiftUI views") { self.topic = .absolutePositioning }
                    Button("Understanding frames and coordinates inside GeometryReader") { self.topic = .framesAndCoordinates }
                    Button("ScrollView effects using GeometryReader") { self.topic = .scrollViewEffect }
                }
                .foregroundColor(.accentColor)
            }
            .navigationBarTitle("Layout and Geometry")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
