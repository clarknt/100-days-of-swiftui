//
//  BindingsAnimation.swift
//  Project6
//
//  Created by clarknt on 2019-10-26.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct BindingsAnimation: View {
    @State private var animationAmount: CGFloat = 1

    var body: some View {
        print(animationAmount)

        return VStack {
            Stepper("Scale amount",
                    value: $animationAmount.animation(
                        Animation.easeInOut(duration: 1)
                            .repeatCount(3, autoreverses: true)
                    ),
                    in: 1...10)

            Spacer()

            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
    }
}

struct BindingsAnimation_Previews: PreviewProvider {
    static var previews: some View {
        BindingsAnimation()
    }
}
