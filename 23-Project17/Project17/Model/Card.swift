//
//  Card.swift
//  Project17
//
//  Created by clarknt on 2020-01-07.
//  Copyright © 2020 clarknt. All rights reserved.
//

import Foundation

struct Card: Codable, Identifiable {
    let id = UUID()
    let prompt: String
    let answer: String

    static var example: Card {
        return Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
