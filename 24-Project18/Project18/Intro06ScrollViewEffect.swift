//
//  Intro06ScrollView.swift
//  Project18
//
//  Created by clarknt on 2020-01-13.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct Intro06ScrollViewEffect: View {
    @State private var displayHelix = true
    @Binding var topic: Topics

    var body: some View {
        Group {
            if displayHelix {
                Helix()
            }
            else {
                CoverFlow()
            }
        }
        .onTapGesture(count: 2) { self.topic = .none }
        .onTapGesture { self.displayHelix.toggle() }
    }
}

struct Helix: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(width: fullView.size.width)
                            .background(self.colors[index % 7])
                            //.rotation3DEffect(.degrees(Double(geo.frame(in: .global).minY) / 5),
                            //                  axis: (x: 0, y: 1, z: 0))
                            .rotation3DEffect(
                                .degrees(
                                    Double(geo.frame(in: .global).minY - fullView.size.height / 2) / 5
                                ),
                                axis: (x: 0, y: 1, z: 0)
                            )
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

struct CoverFlow: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<50) { index in
                        GeometryReader { geo in
                            Rectangle()
                                .fill(self.colors[index % 7])
                                .frame(height: 150)
                                .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                        }
                        .frame(width: 150)
                    }
                }
                .padding(.horizontal, ((fullView.size.width - 150) / 2))
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Intro06ScrollView_Previews: PreviewProvider {
    static var previews: some View {
        Intro06ScrollViewEffect(topic: .constant(.scrollViewEffect))
    }
}
