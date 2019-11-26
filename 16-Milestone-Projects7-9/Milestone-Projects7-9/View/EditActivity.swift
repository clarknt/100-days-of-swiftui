//
//  EditActivity.swift
//  Milestone-Projects7-9
//
//  Created by clarknt on 2019-11-25.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct EditActivity: View {
    // binding the activity directly instead of passing habits + activityId would be cleaner
    // but @Binding has not yet been seen at this part of the 100 days of SwiftUI course
    // so here's a solution without it
    @ObservedObject var habits: Habits
    var activityId: UUID

    @State var completedTimes: Int = 0

    var activity: Activity {
        habits.getActivity(id: activityId)
    }

    var body: some View {
        Form {
            Text(activity.title)
            Text(activity.description)
            Stepper(
                onIncrement: { self.updateActivity(by: 1) },
                onDecrement: { self.updateActivity(by: -1) },
                label: { Text("Completed \(activity.completedTimes) times") }
            )
        }
        .navigationBarTitle("Edit Activity")
    }

    func updateActivity(by change: Int) {
        var activity = self.activity
        activity.completedTimes += change
        self.habits.update(activity: activity)
    }
}

struct EditActivity_Previews: PreviewProvider {
    static var previews: some View {
        EditActivity(habits: Habits(), activityId: UUID())
    }
}
