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

    func add(activity: Activity) {
        activities.append(activity)
    }
}
