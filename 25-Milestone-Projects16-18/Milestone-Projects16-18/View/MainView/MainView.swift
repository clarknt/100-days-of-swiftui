//
//  MainView.swift
//  Milestone-Projects16-18
//
//  Created by clarknt on 2020-01-20.
//  Copyright © 2020 clarknt. All rights reserved.
//

import CoreHaptics
import SwiftUI

struct MainConstants {
    static let lightDisabledOpacity = 0.6
    static let darkDisabledOpacity = 0.4

    static let pickerDefaultOpacity = 0.8
    static let rollButtonDefaultOpacity = 0.8

    static let lightDividerOpacity = 0.1
    static let darkDividerOpacity = 0.3

    static let numbersSaturation = 0.7
    static let numbersBrightness = 0.8

    static let maxDiceNumber = 6
}

struct MainView<GenericRolls: Rolls>: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    @ObservedObject var rolls: GenericRolls

    // MARK:- Private properties

    @State private var diceNumber = 6
    @State private var dieSides = 6

    @State private var animationCompletions = Array<Double>(repeating: 1, count: MainConstants.maxDiceNumber)
    @State private var previousSides = Array<Int>(repeating: 1, count: MainConstants.maxDiceNumber)
    @State private var selectedSides = Array<Int>(repeating: 1, count: MainConstants.maxDiceNumber)
    @State private var animationComplete = true

    @State private var rollDisabled = false

    @State private var coloredNumbers = true

    @State private var showingAction = false

    @State private var engine: CHHapticEngine?

    private var pickerOpacity: Double {
        if rollDisabled {
            return colorScheme == .light ?
                MainConstants.lightDisabledOpacity :
                MainConstants.darkDisabledOpacity
        }

        return MainConstants.pickerDefaultOpacity
    }

    private var rollButtonOpacity: Double {
        if rollDisabled {
            return colorScheme == .light ?
                MainConstants.lightDisabledOpacity :
                MainConstants.darkDisabledOpacity
        }

        return MainConstants.rollButtonDefaultOpacity
    }

    private var dividerOpacity: Double {
        colorScheme == .light ?
            MainConstants.lightDividerOpacity :
            MainConstants.darkDividerOpacity
    }

    private var slotsBackground: Color {
        colorScheme == .light ? .white : .black
    }

    // MARK:- View

    var body: some View {
        let diceNumberWithCallback = Binding<Int>(
            get: { self.diceNumber },
            set: {
                self.diceNumber = $0
                self.resetPositions()
            }
        )

        let dieSidesWithCallback = Binding<Int>(
            get: { self.dieSides },
            set: {
                self.dieSides = $0
                self.resetPositions()
            }
        )

        let animationCompleteWithCallback = Binding<Bool>(
            get: { self.animationComplete },
            set: {
                self.animationComplete = $0
                if self.animationComplete {
                    var result = [Int]()
                    result += self.selectedSides[0..<self.diceNumber]
                    let total = result.reduce(0, +)

                    self.rolls.insert(roll: Roll(dieSides: self.dieSides, result: result, total: total))

                    self.playCompletionHaptics()
                    self.rollDisabled = false
                }
            }
        )

        return VStack {

            // MARK:- Number of dice

            DicePicker(diceNumber: diceNumberWithCallback,
                       rollDisabled: rollDisabled,
                       pickerOpacity: pickerOpacity)
                .padding([.horizontal, .top])

            // MARK:- Number of sides

            SidesPicker(dieSides: dieSidesWithCallback,
                       rollDisabled: rollDisabled,
                       pickerOpacity: pickerOpacity)
                .padding()

            // MARK:- Slots

            ZStack {
                Divider()
                    .background(Color.green.opacity(dividerOpacity))

                HStack {
                    Spacer(minLength: 0)

                    ForEach(0..<self.diceNumber) { i in
                        DieView(sides: self.dieSides,
                                 source: self.previousSides[i],
                                 target: self.selectedSides[i],
                                 percent: self.animationCompletions[i],
                                 complete: i < self.diceNumber - 1 ? .constant(true) : animationCompleteWithCallback)
                            .foregroundColor(self.dieColor(for: i))

                        Spacer(minLength: 0)
                    }
                    .id(self.diceNumber)
                }
            }
            .background(slotsBackground)
            .padding(.vertical)

            ZStack {

                // MARK:- Results

                RollsList(rolls: rolls, showingAction: $showingAction)
                    .padding(.top)
                    .edgesIgnoringSafeArea(.bottom)

                // MARK:- Roll button

                VStack {
                    Spacer()

                    RollButton(rollDisabled: rollDisabled,
                               rollButtonOpacity: rollButtonOpacity,
                               rollAction: rollAction)
                        .padding()
                }
            }
        }
        .modifier(DeleteHistoryModifier(showingAction: $showingAction, action: rolls.removeAll))
    }

    // MARK:- Private functions

    private func rollAction() {
        self.prepareHaptics()
        self.rollDisabled = true

        for i in 0..<self.diceNumber {
            let duration = Double(i + 2) / 2

            self.previousSides[i] = self.selectedSides[i]
            self.animationCompletions[i] = 0
            self.selectedSides[i] = Int.random(in: 1...self.dieSides)
            if i == self.diceNumber - 1 {
                self.animationComplete = false
            }

            withAnimation(.easeOut(duration: duration)) {
                self.animationCompletions[i] = 1
            }
        }
    }

    private func dieColor(for index: Int) -> Color {
        if self.coloredNumbers {
            return Color(
                hue: Double(index) / Double(diceNumber),
                saturation: MainConstants.numbersSaturation,
                brightness: MainConstants.numbersBrightness
            )
        }

        return .primary
    }

    private func resetPositions() {
        for i in 0..<self.diceNumber {
            self.previousSides[i] = 1
            self.selectedSides[i] = 1
            self.animationCompletions[i] = 1
            self.animationComplete = true
        }
    }

    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }

    private func playCompletionHaptics() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one extremely light, blurry tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static let rolls = [
        Roll(dieSides: 20, result: [18, 15, 19, 17, 16, 19], total: 104),
        Roll(dieSides: 6, result: [1, 3, 4], total: 8),
        Roll(dieSides: 100, result: [95, 45, 21, 21, 32], total: 214),
        Roll(dieSides: 8, result: [4, 8, 3], total: 15),
        Roll(dieSides: 4, result: [1, 1, 3, 2, 4], total: 11),
        Roll(dieSides: 6, result: [4, 5, 2, 6, 3, 3], total: 23),
        Roll(dieSides: 6, result: [2, 1, 2, 6, 5, 4], total: 20),
        Roll(dieSides: 6, result: [5, 5, 5, 1, 4, 2], total: 22),
        Roll(dieSides: 6, result: [5, 3, 5, 4, 4], total: 21)
    ]

    class PreviewRolls: Rolls {
        @Published private(set) var all: [Roll]
        var allPublished: Published<[Roll]> { _all }
        var allPublisher: Published<[Roll]>.Publisher { $all }
        init(rolls: [Roll]) { self.all = rolls }
        func insert(roll: Roll) { }
        func removeAll() { }
    }

    static let previewRolls = PreviewRolls(rolls: rolls)

    static var previews: some View {
        Group {
            MainView(rolls: previewRolls).environment(\.colorScheme, .light)

            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                MainView(rolls: previewRolls).environment(\.colorScheme, .dark)
            }

//            MainView(rolls: previewRolls).previewDevice(PreviewDevice(rawValue: "iPhone SE"))
//            MainView(rolls: previewRolls).previewDevice(PreviewDevice(rawValue: "iPhone 8 Plus"))
//            MainView(rolls: previewRolls).previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (3rd generation)"))
        }
    }
}
