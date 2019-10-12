//
//  Temperature.swift
//  ChallengeDay1
//
//  Created by clarknt on 2019-10-11.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

struct Temperature {
    static let celsius = CustomUnit(text: "° Celsius", unit: UnitTemperature.celsius)
    static let farenheit = CustomUnit(text: "° Farenheit", unit: UnitTemperature.fahrenheit)
    static let kelvin = CustomUnit(text: "° Kelvin", unit: UnitTemperature.kelvin)

    static let units = [celsius, farenheit, kelvin]
}
