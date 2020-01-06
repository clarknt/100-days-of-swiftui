//
//  SpecificAccessibility.swift
//  Project17
//
//  Created by clarknt on 2020-01-05.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct SpecificAccessibility: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale1: CGFloat = 1

    @State private var scale2: CGFloat = 1

    @Environment(\.accessibilityReduceTransparency) var reduceTransparency

    var body: some View {
        TabView {
            HStack {
                if differentiateWithoutColor {
                    Image(systemName: "checkmark.circle")
                }

                Text("Success")
            }
            .padding()
            .background(differentiateWithoutColor ? Color.black : Color.green)
            .foregroundColor(Color.white)
            .clipShape(Capsule())
            .tabItem {
                Image(systemName: "1.circle")
                Text("Differentiate without color")
            }

            Text("Motion reduction")
                .padding()
                .scaleEffect(scale1)
                .onTapGesture {
                    if self.reduceMotion {
                        self.scale1 *= 1.5
                    } else {
                        withAnimation {
                            self.scale1 *= 1.5
                        }
                    }
                }
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Motion reduction 1")
                }

            Text("Motion reduction")
                .padding()
                .scaleEffect(scale2)
                .onTapGesture {
                    self.withOptionalAnimation {
                        self.scale2 *= 1.5
                    }
                }
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Motion reduction 2")
                }

            Text("Hello, World!")
                .padding()
                .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
                .foregroundColor(Color.white)
                .clipShape(Capsule())
                .tabItem {
                    Image(systemName: "4.circle")
                    Text("Transparency reduction")
                }
        }
    }

    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
}

struct SpecificAccessibility_Previews: PreviewProvider {
    static var previews: some View {
        SpecificAccessibility()
    }
}
