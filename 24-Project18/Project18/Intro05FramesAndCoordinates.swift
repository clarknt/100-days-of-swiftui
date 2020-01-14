//
//  Intro05FramesAndCoordinates.swift
//  Project18
//
//  Created by clarknt on 2020-01-13.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct Intro05FramesAndCoordinates: View {
    @Binding var topic: Topics

    var body: some View {
        TabView {
            VStack {
                GeometryReader { geo in
                    Text("Hello, World!")
                        .frame(width: geo.size.width * 0.9, height: 40)
                        .background(Color.red)
                }
                .background(Color.green)

                Text("More text")
                    .background(Color.blue)
            }
            .tabItem { Text("GeometryReader") }

            OuterView()
                .background(Color.red)
                .coordinateSpace(name: "Custom")
                .tabItem { Text("CoordinateSpace") }
        }
        .onTapGesture(count: 2) { self.topic = .none }
    }
}

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(Color.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { geo in
                Text("Center")
                    .background(Color.blue)
                    .onTapGesture {
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                    }
            }
            .background(Color.orange)
            Text("Right")
        }
    }
}


struct Intro05FramesAndCoordinates_Previews: PreviewProvider {
    static var previews: some View {
        Intro05FramesAndCoordinates(topic: .constant(.framesAndCoordinates))
    }
}
