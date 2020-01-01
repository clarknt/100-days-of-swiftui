//
//  Challenge3.swift
//  Project9
//
//  Created by clarknt on 2019-11-08.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        color(for: value, brightness: 1, steps: self.steps, amount: self.amount),
                        color(for: value, brightness: 0.5, steps: self.steps, amount: self.amount)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
        // use metal to render image offscreen
        .drawingGroup()
    }
}

struct Challenge3: View {
    @State private var colorCycle = 0.0

    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: self.colorCycle)
                .frame(width: 300, height:  300)

            Slider(value: $colorCycle)
                .padding()

            Spacer()
        }
        .navigationBarTitle("Challenge 3", displayMode: .inline)
    }
}

struct Challenge3_Previews: PreviewProvider {
    static var previews: some View {
        Challenge3()
    }
}
