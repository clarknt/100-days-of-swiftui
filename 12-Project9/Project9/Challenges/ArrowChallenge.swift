//
//  Arrow.swift
//  Project9
//
//  Created by clarknt on 2019-11-08.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

// challenges 1 & 2
struct Arrow: InsettableShape {
    var rectangleWidth: CGFloat = 40
    var triangleBase: CGFloat = 150
    // don't actually use the value like in StrokeBorderSupport, because then the animation jumps
    var insetAmount: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // rectangle
        path.move(to: CGPoint(x: rect.midX - (rectangleWidth / 2), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + (rectangleWidth / 2), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + (rectangleWidth / 2), y: rect.midY))

        // triangle
        path.addLine(to: CGPoint(x: rect.midX + (triangleBase / 2), y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX - (triangleBase / 2), y: rect.midY))

        // rectangle
        path.addLine(to: CGPoint(x: rect.midX - (rectangleWidth / 2), y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX - (rectangleWidth / 2), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + (rectangleWidth / 2), y: rect.maxY))

        return path
    }

    // challenge 2
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
}

struct ArrowChallenge: View {
    @State private var arrowLineThickness: CGFloat = 1

    var body: some View {
        VStack {
            Arrow()
                .strokeBorder(Color.blue, lineWidth: arrowLineThickness)
                .frame(width: 300, height: 300)

            Button("Border size") {
                withAnimation(.linear(duration: 2)) {
                    self.arrowLineThickness = self.arrowLineThickness == 1 ? 20 : 1
                }
            }
            .padding()
        }
        .navigationBarTitle("Challenges 1 & 2", displayMode: .inline)
    }
}

struct Arrow_Previews: PreviewProvider {
    static var previews: some View {
        ArrowChallenge()
    }
}
