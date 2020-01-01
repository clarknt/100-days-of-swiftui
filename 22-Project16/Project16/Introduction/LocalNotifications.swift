//
//  LocalNotifications.swift
//  Project16
//
//  Created by clarknt on 2019-12-22.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI
import UserNotifications

struct LocalNotifications: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set")
                    }
                    else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }

            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default

                // show 5 seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                // ID could be stored to modify notification later
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

struct LocalNotifications_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotifications()
    }
}
