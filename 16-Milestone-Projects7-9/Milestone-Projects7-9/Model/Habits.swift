//
//  Activities.swift
//  Milestone-Projects7-9
//
//  Created by clarknt on 2019-11-25.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

class Habits: ObservableObject {
    private static let habitsKey = "habits"

    @Published var activities = [Activity]() {
        didSet {
            // save data each time the content of the array is modified:
            // addition, removal, but also when modifying an element of the array
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: Self.habitsKey)
            }
        }
    }

    init() {
        if let encoded = UserDefaults.standard.data(forKey: Self.habitsKey) {
            if let decoded = try? JSONDecoder().decode([Activity].self, from: encoded) {
                self.activities = decoded
                return
            }
        }

        self.activities = []
    }

    // provide helper functions to avoid as much as possible a dependency to the activities array
    func add(activity: Activity) {
        activities.append(activity)
        sortActivities()
    }

    func update(activity: Activity) {
        guard let index = getIndex(activity: activity) else { return }

        activities[index] = activity
        sortActivities()
    }

    private func sortActivities() {
        // sort by most recent modification
        activities.sort(by: { $0.date > $1.date } )
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
