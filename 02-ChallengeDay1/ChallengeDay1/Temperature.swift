//
//  Temperature.swift
//  ChallengeDay1
//
//  Created by clarknt on 2019-10-11.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

struct Temperature: Unit {
    static var name = "Temperature"
    
    static let celsius = CustomUnit(name: "Celsius", unit: UnitTemperature.celsius)
    static let farenheit = CustomUnit(name: "Farenheit", unit: UnitTemperature.fahrenheit)
    static let kelvin = CustomUnit(name: "Kelvin", unit: UnitTemperature.kelvin)

    static let units = [celsius, farenheit, kelvin]
}
