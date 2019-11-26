//
//  Activities.swift
//  Milestone-Projects7-9
//
//  Created by clarknt on 2019-11-25.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

class Habits: ObservableObject {
    @Published var activities = [Activity]()

    // provide helper functions to avoid as much as possible a dependency to the activities array
    func add(activity: Activity) {
        activities.append(activity)
    }

    func update(activity: Activity) {
        guard let index = getIndex(activity: activity) else { return }

        activities[index] = activity
    }

    func getActivity(id: UUID) -> Activity {
        guard let index = getIndex(id: id) else { return Activity(title: "", description: "") }

        return activities[index]
    }

    private func getIndex(activity: Activity) -> Int? {
        return activities.firstIndex(where: { $0.id == activity.id })
    }

    private func getIndex(id: UUID) -> Int? {
        return activities.firstIndex(where: { $0.id == id })
    }
}
