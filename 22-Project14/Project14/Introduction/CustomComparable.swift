//
//  CustomComparable.swift
//  Project14
//
//  Created by clarknt on 2019-12-05.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String

    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct CustomComparable: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()

    var body: some View {
        List(users) { user in
            Text("\(user.lastName), \(user.firstName)")
        }
    }
}

struct CustomComparable_Previews: PreviewProvider {
    static var previews: some View {
        CustomComparable()
    }
}
