//
//  Activity.swift
//  Milestone-Projects7-9
//
//  Created by clarknt on 2019-11-25.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

struct Activity: Identifiable {

    let id = UUID()

    var title: String
    var description: String

    var completedTimes: Int = 0 {
        didSet {
            if completedTimes < 0 {
                completedTimes = 0
            }
        }
    }
}
