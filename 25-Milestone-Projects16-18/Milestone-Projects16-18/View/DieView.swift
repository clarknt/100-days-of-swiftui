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

    static let minNumbers = 100
    static let minUniqueNumbersRepeat = 2
    static let numbersPadding = 2
}

struct DieView: View {
    // MARK: - Parameters

    /// Number of sides on the die
    @Binding var sides: Int

    /// Set selected number, or a non-existing number to reset
    /// If animating, resetting before can be useful to get a longer animation
    @Binding var selectedSide: Int

    /// Duration of the slot-like animation that takes effect when changing selectedSide
    @Binding var animationDuration: Double

    // MARK:- Public properties

    /// Maximum number of supported sides
    static let maxSides = 100

    // MARK:- Private properties

    private let maxUniqueNumbers: [Int] = Array(1...maxSides)

    private var numbers: [Int] {
        // match minimum digits
        var repetitions = Int(ceil(Double(DieConstants.minNumbers) / Double(sides)))

        // match minimum repeat
        if repetitions < DieConstants.minUniqueNumbersRepeat {
            repetitions = DieConstants.minUniqueNumbersRepeat
        }

        var numbers = [Int]()

        // build numbers
        for _ in 0..<repetitions {
            numbers += maxUniqueNumbers[0..<sides]
        }

        // add padding
        for i in 0..<DieConstants.numbersPadding {
            // implies a minimum of "padding" unique numbers
            numbers.insert(maxUniqueNumbers[sides - 1 - i], at: 0)
            numbers.append(maxUniqueNumbers[i])
        }

        return numbers
    }

    private var initialOffset: Double {
        let halfCount = CGFloat(numbers.count) / 2
        let firstElement = halfCount - CGFloat(DieConstants.numbersPadding)
        let initialOffset = Double(firstElement * DieConstants.numberFrameHeight) - DieConstants.defaultOffset

        return initialOffset
    }

    private var offset: Double {
        if let index = maxUniqueNumbers.firstIndex(of: selectedSide) {

            if index < sides {
                let relativeOffset = Double(sides - 1 - index) * Double(DieConstants.numberFrameHeight)
                let offset = -initialOffset + relativeOffset

                return offset
            }
        }

        return initialOffset
    }

    // MARK:- View

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
//        .onAppear(perform: initNumbers)
    }

    // MARK:- Private functions

//    private func initNumbers() {
////        let count = maxUniqueNumbers.count
//
//        // match minimum digits
//        var repetitions = Int(ceil(Double(DieConstants.minNumbers) / Double(sides)))
//
//        // match minimum repeat
//        if repetitions < DieConstants.minUniqueNumbersRepeat {
//            repetitions = DieConstants.minUniqueNumbersRepeat
//        }
//
//        // build numbers
//        for _ in 0..<repetitions {
//            numbers += maxUniqueNumbers[0..<sides]
//        }
//
//        // add padding
//        for i in 0..<DieConstants.numbersPadding {
//            // implies a minimum of "padding" unique numbers
//            numbers.insert(maxUniqueNumbers[sides - 1 - i], at: 0)
//            numbers.append(maxUniqueNumbers[i])
//        }
//
//        // compute offsets
//        let halfCount = CGFloat(numbers.count) / 2
//        let firstElement = halfCount - CGFloat(DieConstants.numbersPadding)
//        initialOffset = Double(firstElement * DieConstants.numberFrameHeight) - DieConstants.defaultOffset
//    }

    private func roundToMultiple(number: Double, multiple: Double) -> Double {
        return round(number / multiple) * multiple;
    }

}

struct Die_Previews: PreviewProvider {
    static var previews: some View {
        DieView(sides: .constant(6), selectedSide: .constant(1), animationDuration: .constant(0))
    }
}
