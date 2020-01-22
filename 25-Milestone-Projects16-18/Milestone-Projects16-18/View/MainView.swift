//
//  MainView.swift
//  Milestone-Projects16-18
//
//  Created by clarknt on 2020-01-20.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct MainView: View {
    static private var dieSize = 6
    static private var diceNumber = 6

    @State private var numbers = Array<Int>(repeating: 0, count: diceNumber)
    @State private var animations = Array<Double>(repeating: 0, count: diceNumber)

    @State private var rollDisabled = false

    var body: some View {
        VStack {
            ZStack {
                Divider()

                HStack {
                    Spacer(minLength: 0)

                    ForEach(0..<Self.diceNumber) { i in
                        DieView(uniqueNumbers: Array(1...Self.dieSize), selectedNumber: self.$numbers[i], animationDuration: self.$animations[i])

                        Spacer(minLength: 0)
                    }
                }
            }

            Button(
                action: {
                    self.rollDisabled = true

                    for i in 0..<Self.diceNumber {
                        let duration = Double(i + 2) / 2

                        // reset position
                        self.animations[i] = 0.2
                        self.numbers[i] = 0

                        // if done immediately, it won't have time to reset
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.animations[i] = duration
                            self.numbers[i] = Int.random(in: 1...Self.dieSize)
                        }
                    }

                    let endTime = (Double(Self.diceNumber + 2) / 2)
                    DispatchQueue.main.asyncAfter(deadline: .now() + endTime) {
                        self.rollDisabled = false
                    }
                },
                label: {
                    HStack{
                        Image(systemName: "cube.fill")
                        Text("ROLL")
                            .foregroundColor(Color.white)
                            .font(.headline)
                            .padding(.horizontal)
                        Image(systemName: "cube.fill")
                    }
                    .foregroundColor(rollDisabled ? Color.white : Color.yellow)
                }
            )
            .padding(16)
            .background(rollDisabled ? Color.gray : Color.green)
            .cornerRadius(8)
            .padding()
            .disabled(rollDisabled)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
