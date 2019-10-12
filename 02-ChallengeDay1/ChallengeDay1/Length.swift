//
//  Length.swift
//  ChallengeDay1
//
//  Created by clarknt on 2019-10-12.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

struct Length: Unit {
    static var name = "Length"
    
    static let meters = CustomUnit(name: "Meters", unit: UnitLength.meters)
    static let kilometers = CustomUnit(name: "Kilometers", unit: UnitLength.kilometers)
    static let feet = CustomUnit(name: "Feet", unit: UnitLength.feet)
    static let yards = CustomUnit(name: "Yards", unit: UnitLength.yards)
    static let miles = CustomUnit(name: "Miles", unit: UnitLength.miles)

    static let units = [meters, kilometers, feet, yards, miles]
}
