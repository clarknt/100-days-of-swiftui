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
                Section(header: Text("Unit type")) {
                    Picker("Unit", selection: $unitType) {
                        ForEach(0 ..< Units.types.count, id: \.self) {
                            Text("\(Units.types[$0].name)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section() {
                    TextField("Value", text: $value)
                        .keyboardType(.decimalPad)

                    Button(action: {
                        self.showingSheet = true
                    }) {
                        Text("\(Units.types[self.unitType].units[from[self.unitType]].name) (\(Units.types[self.unitType].units[from[self.unitType]].unit.symbol))")
                    }
                    .actionSheet(isPresented: $showingSheet) {
                        ActionSheet(title: Text("Source \(Units.types[unitType].name)"), message: nil, buttons: actionSheetButtons(for: .source))
                    }

                    // note: a segmented control Picker with a ForEach does not work with
                    // an array that varies in size like it is the case here
                    // this is probably a bug, see https://stackoverflow.com/q/58352798
                    //Picker("in", selection: $from) {
                    //    ForEach(0 ..< Units.types[unitType].units.count, id: \.self) { i in
                    //        Text("\(Units.types[self.unitType].units[i].name) (\(Units.types[self.unitType].units[i].unit.symbol))")
                    //    }
                    //}
                    //.pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("=")) {
                    Text("\(result, specifier: "%.3f")")

                    Button(action: {
                        self.showingSheet = true
                    }) {
                        Text("\(Units.types[self.unitType].units[to[self.unitType]].name) (\(Units.types[self.unitType].units[to[self.unitType]].unit.symbol))")
                    }
                    .actionSheet(isPresented: $showingSheet) {
                        ActionSheet(title: Text("Destination \(Units.types[unitType].name)"), message: nil, buttons: actionSheetButtons(for: .destination))
                    }

                    //Picker("in", selection: $to) {
                    //    ForEach(0 ..< Units.types[unitType].units.count, id: \.self) { i in
                    //        Text("\(Units.types[self.unitType].units[i].name) (\(Units.types[self.unitType].units[i].unit.symbol))")
                    //            .multilineTextAlignment(.leading)
                    //    }
                    //}
                    //.pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Converter")
        }
    }

    func actionSheetButtons(for usage: UnitUsage) -> [ActionSheet.Button] {
        var buttons = [ActionSheet.Button]()

        for i in 0 ..< Units.types[unitType].units.count {
            var baseText = "\(Units.types[self.unitType].units[i].name) (\(Units.types[self.unitType].units[i].unit.symbol))"

            if (usage == .source && i == from[unitType]) || (usage == .destination && i == to[unitType]) {
                baseText = "✓ " + baseText
            }

            buttons.append(.default(Text(baseText)) {
                if usage == .source {
                    self.from[self.unitType] = i
                }
                else {
                    self.to[self.unitType] = i
                }
            })
        }

        buttons.append(.cancel())

        return buttons
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
