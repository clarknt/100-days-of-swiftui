//
//  Order.swift
//  Project15-Challenge1
//
//  Created by clarknt on 2019-11-14.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

// replaced by Order in challenge 3

enum OldOrderCodingKeys: CodingKey {
    case type
    case quantity
    case extraForsting
    case addSprinkles
    case name
    case streetAddress
    case city
    case zip
}

class OldOrder: ObservableObject, Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    @Published var type = 0
    @Published var quantity = 3

    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false

    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""

    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }

        // challenge 1
        if name.isAllSpaces || streetAddress.isAllSpaces || city.isAllSpaces || zip.isAllSpaces {
            return false
        }

        return true
    }

    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: OldOrderCodingKeys.self)

        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)

        try container.encode(extraFrosting, forKey: .extraForsting)
        try container.encode(addSprinkles, forKey: .addSprinkles)

        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OldOrderCodingKeys.self)

        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)

        extraFrosting = try container.decode(Bool.self, forKey: .extraForsting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)

        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }

    init() {

    }
}

// challenge 1
fileprivate extension String {

    var isAllSpaces: Bool {
        guard !self.isEmpty else { return false }
        return self.drop(while: { $0 == " " }).isEmpty
    }
}
