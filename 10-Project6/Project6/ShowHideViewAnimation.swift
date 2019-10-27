//
//  TransitionAnimation.swift
//  Project6
//
//  Created by clarknt on 2019-10-27.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct ShowHideViewAnimation: View {
    @State private var isShowingRed = false

    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    self.isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

struct TransitionAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ShowHideViewAnimation()
    }
}
