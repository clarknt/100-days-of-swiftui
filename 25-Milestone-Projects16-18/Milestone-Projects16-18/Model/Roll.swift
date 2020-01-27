//
//  Roll.swift
//  Milestone-Projects16-18
//
//  Created by clarknt on 2020-01-26.
//  Copyright © 2020 clarknt. All rights reserved.
//

import Foundation

/// A roll and its result
struct Roll: Identifiable {
    var id = UUID()

    /// Number of sides of each die
    var dieSides: Int

    /// Result or the roll, as an array of side values
    var result: [Int]

    /// Sum of the roll
    var total: Int
}
