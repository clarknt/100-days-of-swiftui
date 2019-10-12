//
//  Volume.swift
//  ChallengeDay1
//
//  Created by clarknt on 2019-10-12.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

struct Volume: Unit {
    static var name = "Volume"

    static let milliliters = CustomUnit(name: "Milliliters", unit: UnitVolume.milliliters)
    static let liters = CustomUnit(name: "Liters", unit: UnitVolume.liters)
    static let cups = CustomUnit(name: "Cups", unit: UnitVolume.cups)
    static let pints = CustomUnit(name: "Pints", unit: UnitVolume.pints)
    static let gallons = CustomUnit(name: "Gallons", unit: UnitVolume.gallons)

    static let units = [milliliters, liters, cups, pints, gallons]
}
