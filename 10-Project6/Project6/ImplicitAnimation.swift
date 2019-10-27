//
//  ImplicitAnimation.swift
//  Project6
//
//  Created by clarknt on 2019-10-26.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct ImplicitAnimation: View {
    @State private var animationAmount: CGFloat = 1

    var body: some View {
        Button("Tap Me") {
            self.animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .animation(.default)
        .blur(radius: (animationAmount - 1) * 3)
    }
}

struct ImplicitAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ImplicitAnimation()
    }
}
