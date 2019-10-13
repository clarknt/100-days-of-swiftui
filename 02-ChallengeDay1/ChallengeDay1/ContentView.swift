//
//  ContentView.swift
//  ChallengeDay1
//
//  Created by clarknt on 2019-10-11.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

enum UnitUsage {
    case source
    case destination
}

struct ContentView: View {
    @State private var value = "0"
    @State private var unitType = 0
    @State private var from = Array(repeating: 0, count: Units.types.count)
    @State private var to = Array(repeating: 0, count: Units.types.count)
    @State private var showingSheet = false

    var result: Double {
        let units = Units.types[unitType].units
        let source = Measurement(value: Double(value) ?? 0, unit: units[from[unitType]].unit)
        return source.converted(to: units[to[unitType]].unit).value
    }

    var body: some View {
        NavigationView {
            Form {
                Section() {
                    Picker("Unit", selection: $unitType) {
                        ForEach(0 ..< Units.types.count, id: \.self) {
                            Text("\(Units.types[$0].name)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section() {
                    HStack {
                        TextField("Value", text: $value)
                            .keyboardType(.decimalPad)
                        Spacer()
                        Text(Units.types[unitType].units[from[unitType]].name)
                    }

                    Picker("in", selection: $from[unitType]) {
                        ForEach(0 ..< Units.types[unitType].units.count, id: \.self) { i in
                            Text(Units.types[self.unitType].units[i].unit.symbol)
                        }
                    }
                    .id(unitType) // important with variable number of elements in picker
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("=")) {
                    HStack {
                        Text(format(number: result))
                        Spacer()
                        Text(Units.types[unitType].units[to[unitType]].name)
                    }

                    Picker("in", selection: $to[unitType]) {
                        ForEach(0 ..< Units.types[unitType].units.count, id: \.self) { i in
                            Text(Units.types[self.unitType].units[i].unit.symbol)
                        }
                    }
                    .id(unitType) // important with variable number of elements in picker
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Converter")
        }
        .modifier(DismissingKeyboard())
    }

    // better than %.5f specifier because it removes trailing zeros
    func format(number: Double) -> String {
        let formatter = NumberFormatter()
        let nsnumber = NSNumber(value: number)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 5
        return String(formatter.string(from: nsnumber) ?? "")
    }
}

// allow dismissing keyboard by a double tap outside
// (using a single tap breaks the Pickers)
struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content.onTapGesture(count: 2) {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            keyWindow?.endEditing(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
