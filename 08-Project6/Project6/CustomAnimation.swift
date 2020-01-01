//
//  CustomAnimation.swift
//  Project6
//
//  Created by clarknt on 2019-10-26.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct CustomAnimation: View {
    @State private var animationAmount: CGFloat = 1

    var body: some View {
        Button("Tap Me") {

        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.red)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: false)
            )
        )
            .onAppear {
                self.animationAmount = 2
        }
    }
}

struct CustomAnimation_Previews: PreviewProvider {
    static var previews: some View {
        CustomAnimation()
    }
}
