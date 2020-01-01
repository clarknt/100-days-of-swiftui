//
//  AnimationStack.swift
//  Project6
//
//  Created by clarknt on 2019-10-26.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct AnimationStack: View {
    @State private var enabled = false

    var body: some View {
        Button("Tap Me") {
            self.enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? Color.blue : Color.red)
        .animation(nil)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.interpolatingSpring(stiffness: 10, damping: 1))
    }
}

struct AnimationStack_Previews: PreviewProvider {
    static var previews: some View {
        AnimationStack()
    }
}
