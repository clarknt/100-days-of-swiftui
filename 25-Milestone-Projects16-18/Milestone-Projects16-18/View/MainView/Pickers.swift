//
//  MainViewPickers.swift
//  Milestone-Projects16-18
//
//  Created by clarknt on 2020-02-02.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct DicePicker: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    @Binding var diceNumber: Int
    let rollDisabled: Bool
    let pickerOpacity: Double

    var body: some View {
        VStack {
            HStack {
                Text("Dice").font(.caption)
                Spacer()
            }
            .padding(.leading, 2)

            Picker("", selection: $diceNumber) {
                ForEach(1...6, id: \.self) { i in
                    Text("\(i)").tag(i)

                }
            }
            .modifier(CustomPickerStyle(rollDisabled: rollDisabled, pickerOpacity: pickerOpacity))
        }
    }
}

struct SidesPicker: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    @Binding var dieSides: Int
    let rollDisabled: Bool
    let pickerOpacity: Double

    var body: some View {
        VStack {
            HStack {
                Text("Sides").font(.caption)
                Spacer()
            }
            .padding(.leading, 2)

            Picker("", selection: $dieSides) {
                Text("4").tag(4)
                Text("6").tag(6)
                Text("8").tag(8)
                Text("10").tag(10)
                Text("12").tag(12)
                Text("20").tag(20)
                Text("100").tag(100)
            }
            .modifier(CustomPickerStyle(rollDisabled: rollDisabled, pickerOpacity: pickerOpacity))
        }
    }
}

struct CustomPickerStyle: ViewModifier {
    let rollDisabled: Bool
    let pickerOpacity: Double

    func body(content: Content) -> some View {
        content
            .pickerStyle(SegmentedPickerStyle())
            .disabled(rollDisabled)
            .background(Color.green.opacity(pickerOpacity))
            .cornerRadius(8)
            .animation(.linear(duration: 0.1))
    }
}

struct Pickers_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DicePicker(diceNumber: .constant(6), rollDisabled: false, pickerOpacity: 0.8)
                .padding()

            DicePicker(diceNumber: .constant(6), rollDisabled: true, pickerOpacity: 0.6)
                .padding()

            SidesPicker(dieSides: .constant(6), rollDisabled: false, pickerOpacity: 0.8)
                .padding()

            SidesPicker(dieSides: .constant(6), rollDisabled: true, pickerOpacity: 0.6)
                .padding()
        }
    }
}
