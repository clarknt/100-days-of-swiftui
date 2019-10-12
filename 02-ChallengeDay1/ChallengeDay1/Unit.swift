//
//  Units.swift
//  ChallengeDay1
//
//  Created by clarknt on 2019-10-12.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

protocol Unit {
    static var name: String { get }
    static var units: [CustomUnit] { get }
}
