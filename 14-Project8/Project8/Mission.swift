//
//  Mission.swift
//  Project8
//
//  Created by clarknt on 2019-11-02.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
