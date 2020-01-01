//
//  Astronauts.swift
//  Project15-Challenge3
//
//  Created by clarknt on 2019-11-04.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

struct Astronauts {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
}
