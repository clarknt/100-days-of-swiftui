//
//  AnimationGestures2.swift
//  Project6
//
//  Created by clarknt on 2019-10-27.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct AnimatedGestures2: View {
    let letters = Array("Hello SwiftUI")

    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { i in
                Text(String(self.letters[i]))
                    .padding(5)
                    .font(.title)
                    .background(self.enabled ? Color.blue : Color.red)
                    .offset(self.dragAmount)
                    .animation(
                        Animation.default
                        .delay(Double(i) / 20)
                    )
            }
        }
        .gesture(
            DragGesture()
                .onChanged({ action in self.dragAmount = action.translation })
                .onEnded({ _ in
                    self.dragAmount = .zero
                    self.enabled.toggle()
                })
        )
    }
}

struct AnimationGestures2_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedGestures2()
    }
}
