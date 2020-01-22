//
//  MainView.swift
//  Milestone-Projects16-18
//
//  Created by clarknt on 2020-01-20.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct IdentifiableInt: Identifiable {
    let id = UUID()

    var value: Int
}

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    static private let maxDiceNumber = 6
    @State private var diceNumber = 6

    @State private var dieSides = 6

    @State private var selectedSides = Array<Int>(repeating: 0, count: Self.maxDiceNumber)
    @State private var animationDurations = Array<Double>(repeating: 0, count: 6)

    @State private var rollDisabled = false

    @State private var colored = true

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
//            Text("Roll the dice")
//                .font(.title)
//                .foregroundColor(Color.green)

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
            .background(
                Color.green.opacity(
                    self.rollDisabled ?
                    (self.colorScheme == .light ? 0.5 : 0.3) :
                    0.8
                )
            )
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
            .background(
                Color.green.opacity(
                    self.rollDisabled ?
                    (self.colorScheme == .light ? 0.5 : 0.3) :
                    0.8
                )
            )
            .cornerRadius(8)
            .disabled(self.rollDisabled)
            .animation(.linear(duration: 0.1))
            .padding([.horizontal, .bottom])

            // MARK:- Slots

            ZStack {
                Divider()
                    .background(Color.green.opacity(0.001))

//                RoundedRectangle(cornerRadius: 0)
//                    .stroke(Color.green.opacity(0.3), lineWidth: 0.5)
//                    .frame(height: 40)
//                    .padding(.horizontal, -10)

                HStack {
                    Spacer(minLength: 0)

                    ForEach(0..<self.diceNumber) { i in
                        DieView(sides: self.$dieSides,
                                selectedSide: self.$selectedSides[i],
                                animationDuration: self.$animationDurations[i])
                            .foregroundColor(
                                self.colored ?
                                    Color(hue: Double(i) / Double(self.diceNumber),
                                          saturation: 0.7,
                                          brightness: 0.8) :
                                    .primary
                            )

                        Spacer(minLength: 0)
                    }
                    .id(self.diceNumber)
                }
            }
            .padding(.top)

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
                        self.rollDisabled = false
                    }
                },
                label: {
                    HStack{
                        Text("⚁")
                            .font(.largeTitle)
                            .rotationEffect(.radians(.pi / 8))
                        Text("ROLL")
                            .font(.title)
                            .padding(.horizontal)
                        Text("⚄")
                            .font(.largeTitle)
                            .rotationEffect(.radians(.pi / 8))
                    }
                }
            )
            .foregroundColor(Color.white)
            .padding()
            .background(self.rollDisabled ? Color.green : Color.green)
            .opacity(self.rollDisabled ?
                (self.colorScheme == .light ? 0.5 : 0.3) :
                1
            )
            .animation(.linear(duration: 0.1))
            .cornerRadius(16)
            .padding()
            .disabled(self.rollDisabled)

//            List {
//                Text("Item 1")
//                Text("Item 2")
//                Text("Item 3")
//            }.listStyle(GroupedListStyle())
//            .environment(\.horizontalSizeClass, .regular)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView().environment(\.colorScheme, .light)

//            MainView().environment(\.colorScheme, .dark)
//            MainView().previewDevice(PreviewDevice(rawValue: "iPhone SE"))
//            MainView().previewDevice(PreviewDevice(rawValue: "iPhone 8 Plus"))
//            MainView().previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (3rd generation)"))
        }
    }
}
