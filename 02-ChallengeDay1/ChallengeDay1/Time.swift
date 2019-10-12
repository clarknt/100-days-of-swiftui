//
//  Time.swift
//  ChallengeDay1
//
//  Created by clarknt on 2019-10-12.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

struct Time: Unit {
    static var name = "Time"

    static let seconds = CustomUnit(name: "Seconds", unit: UnitDuration.seconds)
    static let minutes = CustomUnit(name: "Minutes", unit: UnitDuration.minutes)
    static let hours = CustomUnit(name: "Hours", unit: UnitDuration.hours)

    static let units = [seconds, minutes, hours]
}
