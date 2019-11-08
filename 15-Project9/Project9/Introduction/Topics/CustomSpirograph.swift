//
//  CustomSpirograh.swift
//  Project9
//
//  Created by clarknt on 2019-11-07.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

import SwiftUI

// bonus: spirograph with animated transitions
extension Spirograph {
    public var animatableData: AnimatablePair<Double, AnimatablePair<Double, AnimatablePair<Double, CGFloat>>> {
        get {
            AnimatablePair(Double(innerRadius), AnimatablePair(Double(outerRadius), AnimatablePair(Double(distance), amount)))
        }

        set {
            self.innerRadius = Int(newValue.first)
            self.outerRadius = Int(newValue.second.first)
            self.distance = Int(newValue.second.second.first)
            self.amount = newValue.second.second.second
        }
    }
}

struct CustomSpirograph: View {
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var amount: CGFloat = 1.0
    @State private var hue = 0.6

    @State private var randomInnerRadius = false
    @State private var randomOuterRadius = false
    @State private var randomDistance = false
    @State private var randomAmount = false
    @State private var randomColor = false

    @State private var animationDuration = 0.5

    var body: some View {
        // since metal rendering clips the shape (contrary to core animation rendering),
        // put drawing in a ZStack to draw behind the controls and take all the space
        ZStack {
            Spirograph(innerRadius: Int(self.innerRadius), outerRadius: Int(self.outerRadius), distance: Int(self.distance), amount: self.amount)
                .stroke(Color(hue: self.hue, saturation: 1, brightness: 1), lineWidth: 1)
                .drawingGroup() // improve randomize performance
                .offset(CGSize(width: 0, height: -185)) // bump it up

            VStack(spacing: 0) {
                Spacer()

                Group {
                    Text("Inner radius: \(Int(innerRadius))")
                    HStack {
                        Slider(value: $innerRadius, in: 10...150, step: 1)
                        // bonus: animated random values
                        Button(
                            action: { self.randomInnerRadius.toggle() },
                            label: { Image(systemName: randomInnerRadius ? "checkmark.square" : "square") }
                        )
                    }
                    .padding([.horizontal, .bottom])

                    Text("Outer radius: \(Int(outerRadius))")
                    HStack {
                        Slider(value: $outerRadius, in: 10...150, step: 1)
                        // bonus: animated random values
                        Button(
                            action: { self.randomOuterRadius.toggle() },
                            label: { Image(systemName: randomOuterRadius ? "checkmark.square" : "square") }
                        )
                    }
                    .padding([.horizontal, .bottom])

                    Text("Distance: \(Int(distance))")
                    HStack {
                        Slider(value: $distance, in: 10...150, step: 1)
                        // bonus: animated random values
                        Button(
                            action: { self.randomDistance.toggle() },
                            label: { Image(systemName: randomDistance ? "checkmark.square" : "square") }
                        )
                    }
                    .padding([.horizontal, .bottom])

                    Text("Amount: \(amount, specifier: "%.2f")")
                    HStack {
                        Slider(value: $amount)
                        // bonus: animated random values
                        Button(
                            action: { self.randomAmount.toggle() },
                            label: { Image(systemName: randomAmount ? "checkmark.square" : "square") }
                        )
                    }
                    .padding([.horizontal, .bottom])

                    Text("Color")
                    HStack {
                        Slider(value: $hue)
                        // bonus: animated random values
                        Button(
                            action: { self.randomColor.toggle() },
                            label: { Image(systemName: randomColor ? "checkmark.square" : "square") }
                        )
                    }
                    .padding([.horizontal])
                }

                // bonus: animated random values
                HStack {
                    Button("Randomize") {
                        withAnimation(.linear(duration: self.animationDuration)) {
                            if self.randomInnerRadius { self.innerRadius = Double.random(in: 10...150) }
                            if self.randomOuterRadius { self.outerRadius = Double.random(in: 10...150) }
                            if self.randomDistance { self.distance = Double.random(in: 10...150) }
                            if self.randomAmount { self.amount = CGFloat.random(in: 0...1) }
                            if self.randomColor { self.hue = Double.random(in: 0...1) }
                        }
                    }
                    .padding(.leading)
                    .padding(.vertical)

                    Spacer()

                    Stepper(value: $animationDuration, in: 0...5, step: 0.25) {
                        Text("\(animationDuration, specifier: "%.2f")s animation")
                    }
                    .padding(.leading, 25)
                    .padding(.trailing)
                }
            }
        }
        .navigationBarTitle("Animated spirograph", displayMode: .inline)
    }
}

struct CustomSpirograph_Previews: PreviewProvider {
    static var previews: some View {
        DefaultSpirograph()
    }
}
