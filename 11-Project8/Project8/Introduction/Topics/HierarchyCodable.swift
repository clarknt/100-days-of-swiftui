//
//  HierarchyCodable.swift
//  Project8
//
//  Created by clarknt on 2019-11-02.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct HierarchyCodable: View {
    var body: some View {
        Button("Decode JSON") {
            let input = """
                {
                    "name": "Taylor Swift",
                    "address": {
                        "street": "555, Taylor Swift Avenue",
                        "city": "Nashville"
                    }
                }
            """

            struct User: Codable {
                var name: String
                var address: Address
            }

            struct Address: Codable {
                var street: String
                var city: String
            }

            let data = Data(input.utf8)
            let decoder = JSONDecoder()

            if let user = try? decoder.decode(User.self, from: data) {
                print(user.address.street)
            }
        }
    }
}

struct HierarchyCodable_Previews: PreviewProvider {
    static var previews: some View {
        HierarchyCodable()
    }
}
