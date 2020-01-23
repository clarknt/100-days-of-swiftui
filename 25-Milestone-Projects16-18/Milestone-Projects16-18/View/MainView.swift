//
//  MainView.swift
//  Milestone-Projects16-18
//
//  Created by clarknt on 2020-01-20.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct Roll: Identifiable {
    var id = UUID()
    var dieSides: Int
    var result: [Int]
    var total: Int
}

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

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    @State var rolls = [Roll]()

    // MARK:- Private properties

    @State private var diceNumber = 6
    @State private var dieSides = 6

    @State private var selectedSides =
        Array<Int>(repeating: 0, count: MainConstants.maxDiceNumber)
    
    @State private var animationDurations =
        Array<Double>(repeating: 0, count: MainConstants.maxDiceNumber)

    @State private var rollDisabled = false

    @State private var coloredNumbers = true

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

    private var total: Int {
        var total = 0

        for i in 0..<diceNumber {
            total += selectedSides[i]
        }

        return total
    }

    // MARK:- View

    var body: some View {
        let diceNumberWithCallback = Binding<Int>(
            get: { self.diceNumber },
            set: { self.diceNumber = $0 }
        )

        let dieSidesWithCallback = Binding<Int>(
            get: { self.dieSides },
            set: {
                self.dieSides = $0

                // reset positions
                for i in 0..<self.diceNumber {
                    self.animationDurations[i] = 0
                    self.selectedSides[i] = 0
                }
            }
        )

        return VStack {

            // MARK:- Number of dice

            HStack {
                Text("Dice")
                    .font(.caption)

                Spacer()
            }
            .padding([.horizontal, .top])
            .padding(.leading, 2)

            Picker("", selection: diceNumberWithCallback) {
                ForEach(1...6, id: \.self) { i in
                    Text("\(i)").tag(i)

                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .disabled(self.rollDisabled)
            .background(Color.green.opacity(pickerOpacity))
            .cornerRadius(8)
            .animation(.linear(duration: 0.1))
            .padding(.horizontal)

            // MARK:- Number of sides

            HStack {
                Text("Sides")
                    .font(.caption)

                Spacer()
            }
            .padding([.horizontal, .top])
            .padding(.leading, 2)

            Picker("", selection: dieSidesWithCallback) {
                Text("4").tag(4)
                Text("6").tag(6)
                Text("8").tag(8)
                Text("10").tag(10)
                Text("12").tag(12)
                Text("20").tag(20)
                Text("100").tag(100)
            }
            .pickerStyle(SegmentedPickerStyle())
            .background(Color.green.opacity(pickerOpacity))
            .cornerRadius(8)
            .disabled(self.rollDisabled)
            .animation(.linear(duration: 0.1))
            .padding([.horizontal, .bottom])

            // MARK:- Slots

            ZStack {
                Divider()
                    .background(Color.green.opacity(dividerOpacity))

                HStack {
                    Spacer(minLength: 0)

                    ForEach(0..<self.diceNumber) { i in
                        DieView(sides: self.$dieSides,
                                selectedSide: self.$selectedSides[i],
                                animationDuration: self.$animationDurations[i])
                            .foregroundColor(self.dieColor(for: i))

                        Spacer(minLength: 0)
                    }
                    .id(self.diceNumber)
                }
            }
            .background(slotsBackground)
            .padding(.vertical)

            // MARK:- Results

            List {
                ForEach(rolls) { roll in
                    ZStack {
                        HStack {
                            Text("\(roll.dieSides)")
                            Text("⚁")
                                .rotationEffect(.radians(.pi / 8))

                            Spacer()

                            HStack(alignment: .lastTextBaseline) {
                                Text("Σ")
                                    .font(.caption)
                                Text("\(roll.total)")
                            }
                        }

                        HStack {
                            Spacer()

                            ForEach(roll.result, id: \.self) { side in
                                Text("\(side)")
                            }

                            Spacer()
                        }
                    }
                    .listRowBackground(self.rollColor(for: roll))
                }
            }
            .padding(.vertical)
            .foregroundColor(.gray)
            .onAppear {
                UITableView.appearance().separatorStyle = .none
                UITableView.appearance().backgroundColor = UIColor.clear
            }
            .onDisappear {
                UITableView.appearance().separatorStyle = .singleLine
                UITableView.appearance().backgroundColor = UIColor.systemBackground
            }

            // MARK:- Roll button

            Spacer()

            Button(
                action: {
                    self.rollDisabled = true

                    for i in 0..<self.diceNumber {
                        let duration = Double(i + 2) / 2

                        // reset position
                        self.animationDurations[i] = 0.2
                        self.selectedSides[i] = 0

                        // if done immediately, it won't have time to reset
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.animationDurations[i] = duration
                            self.selectedSides[i] = Int.random(in: 1...self.dieSides)
                        }
                    }

                    let endTime = (Double(self.diceNumber + 2) / 2)
                    DispatchQueue.main.asyncAfter(deadline: .now() + endTime) {
                        var result = [Int]()
                        result += self.selectedSides[0..<self.diceNumber]
                        let total = result.reduce(0, +)

                        self.rolls.insert(Roll(dieSides: self.dieSides, result: result, total: total), at: 0)
                        self.rollDisabled = false
                    }
                },
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
            .opacity(self.rollButtonOpacity)
            .animation(.linear(duration: 0.1))
            .cornerRadius(8)
            .padding()
            .disabled(self.rollDisabled)
        }
    }

    // MARK:- Private functions

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

    private func rollColor(for roll: Roll) -> Color {
        if colorScheme == .light {
            return index(for: roll) % 2 == 0 ?
                Color.green.opacity(0.05) :
                Color.green.opacity(0.15)
        }

        return index(for: roll) % 2 == 0 ?
            Color.white.opacity(0.1) :
            Color.white.opacity(0.075)
    }

    private func index(for roll: Roll) -> Int {
        rolls.firstIndex(where: { roll.id == $0.id }) ?? 0
    }
}

struct MainView_Previews: PreviewProvider {
    static let rolls = [
        Roll(dieSides: 20, result: [18, 15, 19, 17, 16, 19], total: 104),
        Roll(dieSides: 6, result: [1, 3, 4], total: 8),
        Roll(dieSides: 100, result: [95, 45, 21, 21, 32], total: 214)
    ]

    static var previews: some View {
        Group {
            MainView(rolls: rolls).environment(\.colorScheme, .light)

            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                MainView(rolls: rolls).environment(\.colorScheme, .dark)
            }
            
//            MainView(rolls: rolls).previewDevice(PreviewDevice(rawValue: "iPhone SE"))
//            MainView(rolls: rolls).previewDevice(PreviewDevice(rawValue: "iPhone 8 Plus"))
//            MainView(rolls: rolls).previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (3rd generation)"))
        }
    }
}
