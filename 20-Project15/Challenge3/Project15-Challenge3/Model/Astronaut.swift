//
//  Astronaut.swift
//  Project15-Challenge3
//
//  Created by clarknt on 2019-11-02.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String

    var accessibleName: String {
        name.replacingOccurrences(of: ".", with: " ")
    }
}
