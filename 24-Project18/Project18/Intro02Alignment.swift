//
//  Intro02Alignment.swift
//  Project18
//
//  Created by clarknt on 2020-01-10.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct Intro02Alignment: View {
    @Binding var topic: Topics

    var body: some View {
        TabView {
            Text("Live long and prosper")
                .frame(width: 300, height: 300, alignment: .topLeading)
                .offset(x: 10, y: 10)
                .tabItem { Text("Frame") }

            VStack {
                HStack {
                    Text("Live")
                        .font(.caption)
                    Text("long")
                    Text("and")
                        .font(.title)
                    Text("prosper")
                        .font(.largeTitle)
                }
                .padding()

                HStack(alignment: .bottom) {
                    Text("Live")
                        .font(.caption)
                    Text("long")
                    Text("and")
                        .font(.title)
                    Text("prosper")
                        .font(.largeTitle)
                }
                .padding()

                HStack(alignment: .lastTextBaseline) {
                    Text("Live")
                        .font(.caption)
                    Text("long")
                    Text("and")
                        .font(.title)
                    Text("prosper")
                        .font(.largeTitle)
                }
                .padding()
            }
            .tabItem { Text("Stack") }

            VStack(alignment: .leading) {
                Text("Hello, world!")
                Text("This is a longer line of text")
            }
            .background(Color.red)
            .frame(width: 400, height: 400)
            .background(Color.blue)
            .tabItem { Text("Alignment") }

            VStack {
                VStack(alignment: .leading) {
                    Text("Hello, world!")
                        .alignmentGuide(.leading) { d in d[.leading] }
                    Text("This is a longer line of text")
                }
                .padding()

                VStack(alignment: .leading) {
                    Text("Hello, world!")
                        .alignmentGuide(.leading) { d in d[.trailing] }
                    Text("This is a longer line of text")
                }
                .padding()

                VStack(alignment: .leading) {
                    Text("Hello, world!")
                        .alignmentGuide(.leading) { d in d[.trailing] }
                    Text("This is a longer line of text")
                }
                .padding()

                VStack(alignment: .leading) {
                    ForEach(0..<10) { position in
                        Text("Number \(position)")
                            .alignmentGuide(.leading) { _ in CGFloat(position) * -10 }
                    }
                }
                .background(Color.red)
                .frame(width: 400, height: 400)
                .background(Color.blue)
                .padding()
            }
            .tabItem { Text("Alignment Guide") }
        }
        .onTapGesture(count: 2) { self.topic = .none }
    }
}

struct Intro02Alignment_Previews: PreviewProvider {
    static var previews: some View {
        Intro02Alignment(topic: .constant(.alignment))
    }
}
