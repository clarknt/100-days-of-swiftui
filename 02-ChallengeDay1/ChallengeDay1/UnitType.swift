//
//  Units.swift
//  ChallengeDay1
//
//  Created by clarknt on 2019-10-12.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

/// List of units of the same type
protocol UnitType {
    static var name: String { get }
    static var units: [NamedUnit] { get }
}
