//
//  StrokeBorderSupport.swift
//  Project9
//
//  Created by clarknt on 2019-11-06.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct Arc2: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    var insetAmount: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        // compensate the fact that SwiftUI start the arc from the right instead of the top
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        // !clockwise because SwiftUI goes the other way around from one angle to the other

        return path
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct StrokeBorderSupport: View {
    var body: some View {
        ZStack {
            // strokeBorder strokes inside the circle while stroke strokes halfway in, halfway out
            Arc2(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
                .strokeBorder(Color.blue, lineWidth: 40)
        }
        .navigationBarTitle("Stroke border support", displayMode: .inline)
    }
}

struct StrokeBorderSupport_Previews: PreviewProvider {
    static var previews: some View {
        StrokeBorderSupport()
    }
}
