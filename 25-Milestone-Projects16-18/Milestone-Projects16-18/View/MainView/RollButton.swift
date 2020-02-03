//
//  MainViewRollButton.swift
//  Milestone-Projects16-18
//
//  Created by clarknt on 2020-02-02.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct RollButton: View {
    var rollDisabled: Bool
    var rollButtonOpacity: Double
    var rollAction: () -> Void

    var body: some View {
        ZStack {
            // dummy button over the list that acts as a solid background
            // for the roll button. Allows modifying roll button's opacity
            // without the list below showing through
            Button(action: {}, label: {
                    HStack {
                        Spacer()
                        Text(" ").font(.largeTitle)
                        Spacer()
                    }
                }
            )
            .padding(.vertical, 8)
            .background(Color(UIColor.systemBackground))
            .cornerRadius(8)
            .allowsHitTesting(false)

            Button(
                action: rollAction,
                label: {
                    HStack{
                        Spacer()
                        Text("⚁")
                            .font(.largeTitle)
                            .rotationEffect(.radians(.pi / 8))
                        Text("ROLL")
                            .font(.title)
                            .padding(.horizontal)
                        Text("⚄")
                            .font(.largeTitle)
                            .rotationEffect(.radians(.pi / 8))
                        Spacer()
                    }
                }
            )
            .foregroundColor(.primary)
            .padding(.vertical, 8)
            .background(Color.green)
            .opacity(rollButtonOpacity)
            .animation(.linear(duration: 0.1))
            .cornerRadius(8)
            .disabled(rollDisabled)
        }
    }
}

struct RollButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RollButton(rollDisabled: false, rollButtonOpacity: 0.8, rollAction: {})
                .padding()

            RollButton(rollDisabled: true, rollButtonOpacity: 0.6, rollAction: {})
                .padding()
        }
    }
}
