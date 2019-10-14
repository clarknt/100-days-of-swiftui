//
//  Units.swift
//  ChallengeDay1
//
//  Created by clarknt on 2019-10-12.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

/// List of unit types supported in this application
struct UnitTypes {
    static let types: [UnitType.Type] = [Temperature.self, Length.self, Time.self, Volume.self]
}
