//
//  Resort-ViewUtils.swift
//  Project19
//
//  Created by clarknt on 2020-02-07.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

// challenge 3
extension Resort {
    var sizeText: String {
        Self.sizeText(from: size)
    }

    static func sizeText(from size: Int) -> String {
        switch size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }

    static func size(from sizeText: String) -> Int {
        switch sizeText {
        case "Small":
            return 1
        case "Average":
            return 2
        default:
            return 3
        }

    }

    var priceText: String {
        Self.priceText(from: price)
    }

    static func priceText(from price: Int) -> String {
        String(repeating: "$", count: price)
    }

    static func price(from priceText: String) -> Int {
        return priceText.count
    }
}
