//
//  Order.swift
//  Project10
//
//  Created by clarknt on 2019-11-14.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

enum OrderCodingKeys: CodingKey {
    case type
    case quantity
    case extraForsting
    case addSprinkles
    case name
    case streetAddress
    case city
    case zip
}

// challenge 3
class ObservableOrder: ObservableObject {
    @Published var order: Order

    init(order: Order) {
        self.order = order
    }
}

// challenge 3
struct Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false

    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""

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
}

// challenge 1
fileprivate extension String {

    var isAllSpaces: Bool {
        guard !self.isEmpty else { return false }
        return self.drop(while: { $0 == " " }).isEmpty
    }
}
