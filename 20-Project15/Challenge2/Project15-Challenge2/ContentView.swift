//
//  ContentView.swift
//  Project15-Challenge2
//
//  Created by clarknt on 2019-10-20.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    var body: some View {
        NavigationView {
            Form {
                // challenge 1
                Section(header: Text("When do you want to wake up?").font(.headline)) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }

                // challenge 1
                Section(header: Text("Desired amount of sleep").font(.headline)) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                    // Project 15 - Challenge 2
                    .accessibility(value: Text(getAccessibleSleepAmount()))
                }

                // challenge 1
                Section(header: Text("Daily coffee intake").font(.headline)) {
                    // challenge 2 (working but stepper takes less space and is more responsive)
                    //Picker("Coffe intake", selection: $coffeeAmount) {
                    //    ForEach(1...20, id: \.self) { i in
                    //        Text("\(i) \(i == 1 ? "cup" : "cups")")
                    //    }
                    //}
                    //.id("coffee")
                    //.labelsHidden()
                    //.pickerStyle(WheelPickerStyle())

                    Stepper(value: $coffeeAmount, in: 1...20) {
                        Text(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups")
                    }
                    // Project 15 - Challenge 2
                    .accessibility(value: Text(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups"))
                }

                // challenge 3
                Section(header: Text("Recommended bed time").font(.headline)) {
                    Text("\(calculatedBedTime)")
                        .font(.title)
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }

    // Project 15 - Challenge 2
    func getAccessibleSleepAmount() -> String {
        // round sleepAmount
        if floor(sleepAmount) == sleepAmount {
            return String(format: "%g", Double(sleepAmount)) + " hours"
        }
        // minutes
        let hours = Int(floor(sleepAmount))
        let minutesDecimal = sleepAmount - floor(sleepAmount)
        let minutes = Int(minutesDecimal * 60)
        return "\(hours) hours " + "\(minutes) minutes"
    }

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }

    // challenge 3
    var calculatedBedTime: String {
        let model = SleepCalculator()

        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60

        var message: String
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep

            let formatter = DateFormatter()
            formatter.timeStyle = .short

            message = formatter.string(from: sleepTime)
        }
        catch {
            message = "Error calculating bedtime"
        }

        return message
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
