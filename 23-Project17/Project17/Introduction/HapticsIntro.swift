//
//  Haptics.swift
//  Project17
//
//  Created by clarknt on 2020-01-02.
//  Copyright © 2020 clarknt. All rights reserved.
//

import CoreHaptics
import SwiftUI

struct HapticsIntro: View {
    @State private var engine: CHHapticEngine?

    var body: some View {
        VStack {
            Text("Success")
                .padding()
                .onTapGesture(perform: simpleSuccess)

            Text("Warning")
                .padding()
                .onTapGesture {
                    UINotificationFeedbackGenerator().notificationOccurred(.warning)
            }

            Text("Error")
                .padding()
                .onTapGesture {
                    UINotificationFeedbackGenerator().notificationOccurred(.error)
                }

            Text("Custom success - One vibration")
                .padding()
                .onAppear(perform: prepareHaptics)
                .onTapGesture(perform: complexSuccessSingle)

            Text("Custom success - Multiple vibrations")
                .padding()
                .onAppear(perform: prepareHaptics)
                .onTapGesture(perform: complexSuccessMultiple)

        }
    }

    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }

    func complexSuccessSingle() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
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

    func complexSuccessMultiple() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }

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

struct HapticsIntro_Previews: PreviewProvider {
    static var previews: some View {
        HapticsIntro()
    }
}
