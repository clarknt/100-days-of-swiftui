//
//  Die.swift
//  Milestone-Projects16-18
//
//  Created by clarknt on 2020-01-20.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct DieView: View {
    // MARK: - Parameters

    /// Die number of sides
    let sides: Int

    /// Source side to animate from
    let source: Int

    /// Target side to animate to
    let target: Int

    /// Animation percentage
    let percent: Double

    /// True when animation is complete
    @Binding var complete: Bool

    var body: some View {
        Text("100")
            .modifier(
                DieAnimatableModifier(sides: sides,
                                      source: source,
                                      target: target,
                                      percent: percent,
                                      complete: $complete)
            )
    }
}

struct Die_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            DieView(sides: 6, source: 1, target: 3,
                     percent: 0, complete: .constant(true))

            DieView(sides: 6, source: 1, target: 3,
                     percent: 1, complete: .constant(true))

            DieView(sides: 100, source: 1, target: 1,
                     percent: 1, complete: .constant(true))
        }
    }
}
