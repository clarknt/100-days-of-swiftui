//
//  Die.swift
//  Milestone-Projects16-18
//
//  Created by clarknt on 2020-01-20.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct DieConstants {
    static let numberFrameHeight: CGFloat = 40
    static let slotFrameHeight = numberFrameHeight * 3

    static let defaultOffset = 20.0
    static let minimumDigits = 100
    static let minimumRepeat = 2
    static let padding = 2
}

struct DieView: View {
    // MARK: - parameters

    var uniqueNumbers: [Int] = Array(1...6)

    /// Set selected number, or a non-existing number to reset
    /// If animating, resetting before can be useful to get a longer animation
    @Binding var selectedNumber: Int

    @Binding var animationDuration: Double

    // MARK:- private properties

    @State private var numbers = [Int]()

    private var offset: Double {
        if let index = uniqueNumbers.firstIndex(of: selectedNumber) {

            let relativeOffset = Double(uniqueNumbers.count - 1 - index) * Double(DieConstants.numberFrameHeight)
            let offset = -initialOffset + relativeOffset

            return offset
        }

        return initialOffset
    }

    @State private var initialOffset = DieConstants.defaultOffset

    var body: some View {
        VStack {
            HStack {
                VStack {
                    ForEach(numbers, id: \.self) { number in
                        Text("\(number)")
                            .font(.largeTitle)
                            .frame(height: DieConstants.numberFrameHeight)
                    }
                    .offset(x: 0, y: CGFloat(offset))
                    .animation(.easeOut(duration: animationDuration))
                }
                .frame(height: DieConstants.slotFrameHeight)
                .clipped()
            }
        }
        .onAppear(perform: initNumbers)
    }

    private func initNumbers() {
        let count = uniqueNumbers.count

        // match minimum digits
        var repetitions = Int(ceil(Double(DieConstants.minimumDigits) / Double(count)))

        // match minimum repeat
        if repetitions < DieConstants.minimumRepeat {
            repetitions = DieConstants.minimumRepeat
        }

        // build numbers
        for _ in 0..<repetitions {
            numbers += uniqueNumbers
        }

        // add padding
        for i in 0..<DieConstants.padding {
            // implies a minimum of "padding" unique numbers
            numbers.insert(uniqueNumbers[count - 1 - i], at: 0)
            numbers.append(uniqueNumbers[i])
        }

        // compute offsets
        let halfCount = CGFloat(numbers.count) / 2
        let firstElement = halfCount - CGFloat(DieConstants.padding)
        initialOffset = Double(firstElement * DieConstants.numberFrameHeight) - DieConstants.defaultOffset
    }

    private func roundToMultiple(number: Double, multiple: Double) -> Double {
        return round(number / multiple) * multiple;
    }

}

struct Die_Previews: PreviewProvider {
    static var previews: some View {
        DieView(selectedNumber: .constant(1), animationDuration: .constant(0))
    }
}
