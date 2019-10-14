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
    /// Input value
    @State private var value = "0"

    /// Selected unit type index
    @State private var unitTypeIndex = 0

    /// Selected source indexes for all unit types
    @State private var sourceNamedUnitIndexes = Array(repeating: 0, count: UnitTypes.types.count)

    /// Selected destination indexes for all unit types
    @State private var destinationNamedUnitIndexes = Array(repeating: 0, count: UnitTypes.types.count)

    /// Available unit types
    var unitTypes: [UnitType.Type] {
        return UnitTypes.types
    }

    /// Available units for selected unit type
    var namedUnits: [NamedUnit] {
        return unitTypes[unitTypeIndex].units
    }

    /// Selected source unit
    var sourceNamedUnit: NamedUnit {
        let selectedSourceIndex = sourceNamedUnitIndexes[unitTypeIndex]
        return namedUnits[selectedSourceIndex]
    }

    /// Selected destination unit
    var destinationNamedUnit: NamedUnit {
        let selectedDestinationIndex = destinationNamedUnitIndexes[unitTypeIndex]
        return namedUnits[selectedDestinationIndex]
    }

    /// Conversion result
    var result: Double {
        let source = Measurement(value: Double(value) ?? 0, unit: sourceNamedUnit.unit)
        return source.converted(to: destinationNamedUnit.unit).value
    }

    var body: some View {
        NavigationView {
            Form {
                // unit type selection
                Section() {
                    Picker("Unit", selection: $unitTypeIndex) {
                        ForEach(0 ..< unitTypes.count, id: \.self) {
                            Text("\(self.unitTypes[$0].name)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section() {
                    // input value
                    HStack {
                        TextField("Value", text: $value)
                            .keyboardType(.decimalPad)
                        Spacer()
                        Text(sourceNamedUnit.name)
                    }

                    // source unit selection
                    Picker("in", selection: $sourceNamedUnitIndexes[unitTypeIndex]) {
                        ForEach(0 ..< namedUnits.count, id: \.self) { i in
                            Text(self.namedUnits[i].unit.symbol)
                        }
                    }
                    .id(unitTypeIndex) // important with variable number of elements in picker
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("=")) {
                    // conversion result
                    HStack {
                        Text(format(number: result))
                        Spacer()
                        Text(destinationNamedUnit.name)
                    }

                    // destination unit selection
                    Picker("in", selection: $destinationNamedUnitIndexes[unitTypeIndex]) {
                        ForEach(0 ..< namedUnits.count, id: \.self) { i in
                            Text(self.namedUnits[i].unit.symbol)
                        }
                    }
                    .id(unitTypeIndex) // important with variable number of elements in picker
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Converter")
        }
        .modifier(DismissingKeyboard())
    }

    /// Format a number with up to 5 digits after the decimal point
    func format(number: Double) -> String {
        // better than %.5f specifier because it removes trailing zeros
        let formatter = NumberFormatter()
        let nsnumber = NSNumber(value: number)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 5
        return String(formatter.string(from: nsnumber) ?? "")
    }
}

/// Dismiss keyboard by a double tap outside the keyboard
struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        // note: using a single tap breaks the Pickers
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
