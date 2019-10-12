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

    static let celsiusText = "° Celsius"
    static let farenheitText = "° Farenheit"
    static let kelvinText = "Kelvin"
    let temperatureUnits = [ContentView.celsiusText, ContentView.farenheitText, ContentView.kelvinText]

    var result: Double {
        convertTemperature()
    }

    var body: some View {
        NavigationView {
            Form {
                Section() {
                    TextField("Value", text: $value)

                    Picker("From", selection: $from) {
                        ForEach(0 ..< temperatureUnits.count) {
                            Text(self.temperatureUnits[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }


                Section(header: Text("=")) {
                    Text("\(result, specifier: "%.2f")")

                    Picker("To", selection: $to) {
                        ForEach(0 ..< temperatureUnits.count) {
                            Text(self.temperatureUnits[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Converter")
        }
    }

    func convertTemperature() -> Double {
        let fromInCelsius = convertFromTemperature()
        return convertToTemperature(fromInCelsius: fromInCelsius)
    }

    func convertFromTemperature() -> Double {
        switch temperatureUnits[from] {
        case ContentView.celsiusText:
            return Double(value) ?? 0
        case ContentView.farenheitText:
            return farenheitToCelsius(value: Double(value) ?? 0)
        case ContentView.kelvinText:
            return kelvinToCelsius(value: Double(value) ?? 0)
        default:
            return 0
        }
    }

    func convertToTemperature(fromInCelsius: Double) -> Double {
        switch temperatureUnits[to] {
        case ContentView.celsiusText:
            return fromInCelsius
        case ContentView.farenheitText:
            return celsiusToFarenheit(value: fromInCelsius)
        case ContentView.kelvinText:
            return celsiusToKelvin(value: fromInCelsius)
        default:
            return 0
        }
    }

    func farenheitToCelsius(value: Double) -> Double {
        return (value - 32) * 5 / 9
    }

    func celsiusToFarenheit(value: Double) -> Double {
        return (value * 9 / 5) + 32
    }

    func kelvinToCelsius(value: Double) -> Double {
        return value - 273.15
    }

    func celsiusToKelvin(value: Double) -> Double {
        return value + 273.15
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
