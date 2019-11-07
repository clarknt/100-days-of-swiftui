//
//  MetalRendering.swift
//  Project9
//
//  Created by clarknt on 2019-11-06.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    var coreAnimation = true

    var body: some View {
        Group {
            if coreAnimation {
                ZStack {
                    ForEach(0..<steps) { value in
                        Circle()
                            .inset(by: CGFloat(value))
                            .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
                    }
                }
            }
            else {
                ZStack {
                    ForEach(0..<steps) { value in
                        Circle()
                            .inset(by: CGFloat(value))
                            .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                                self.color(for: value, brightness: 1),
                                self.color(for: value, brightness: 0.5)
                            ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
                    }
                }
                // use metal to render image offscreen
                .drawingGroup()
            }
        }
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct MetalRendering: View {
    @State private var colorCycle = 0.0
    @State private var selectedView = 0

    var body: some View {
        TabView(selection: $selectedView) {
            Group {
                VStack {
                    ColorCyclingCircle(amount: self.colorCycle)
                        .frame(width: 300, height:  300)

                    Slider(value: $colorCycle)
                        .padding()
                }
            }
            .tabItem {
                Image(systemName: "1.circle")
                Text("Core animation")
            }
            .tag(0)

            Group {
                VStack {
                    ColorCyclingCircle(amount: self.colorCycle, coreAnimation: false)
                        .frame(width: 300, height:  300)

                    Slider(value: $colorCycle)
                        .padding()
                }
            }
            .tabItem {
                Image(systemName: "2.circle")
                Text("Metal")
            }
            .tag(1)

        }
    }
}

struct MetalRendering_Previews: PreviewProvider {
    static var previews: some View {
        MetalRendering()
    }
}
