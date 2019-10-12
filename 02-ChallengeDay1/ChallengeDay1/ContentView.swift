//
//  ContentView.swift
//  ChallengeDay1
//
//  Created by clarknt on 2019-10-11.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var from = 0
    @State private var to = 0
    @State private var value = "0"

    var result: Double {
        let source = Measurement(value: Double(value) ?? 0, unit: Temperature.units[from].unit)

        return source.converted(to: Temperature.units[to].unit).value
    }

    var body: some View {
        NavigationView {
            Form {
                Section() {
                    TextField("Value", text: $value)

                    Picker("From", selection: $from) {
                        ForEach(0 ..< Temperature.units.count) {
                            Text(Temperature.units[$0].text)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("=")) {
                    Text("\(result, specifier: "%.2f")")

                    Picker("To", selection: $to) {
                        ForEach(0 ..< Temperature.units.count) {
                            Text(Temperature.units[$0].text)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
