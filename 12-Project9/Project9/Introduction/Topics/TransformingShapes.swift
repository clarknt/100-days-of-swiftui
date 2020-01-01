//
//  TransformingShapes.swift
//  Project9
//
//  Created by clarknt on 2019-11-06.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct Flower: Shape {
    var petalOffset: Double = -20 // distance from the center
    var petalWidth: Double = 100

    func path(in rect: CGRect) -> Path {
        var path = Path()

        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))

            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))
            let rotatedPetal = originalPetal.applying(position)

            path.addPath(rotatedPetal)
        }

        return path
    }
}

struct TransformingShapes: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0

    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .fill(Color.red, style: FillStyle(eoFill: true)) // eo for even/odd

            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])

            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding([.horizontal, .bottom])
        }
        .navigationBarTitle("Transforming shapes", displayMode: .inline)
    }
}

struct TransformingShapes_Previews: PreviewProvider {
    static var previews: some View {
        TransformingShapes()
    }
}
