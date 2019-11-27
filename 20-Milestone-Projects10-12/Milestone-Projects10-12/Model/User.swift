//
//  User.swift
//  Milestone-Projects10-12
//
//  Created by clarknt on 2019-11-26.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var friends: [Friend]
}
