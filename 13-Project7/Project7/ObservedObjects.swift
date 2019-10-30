//
//  ObservedObjects.swift
//  Project7
//
//  Created by clarknt on 2019-10-29.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct ObservedObjects: View {
    // not private to make it clear that the object is shared
    @ObservedObject var user = User()

    var body: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 10) {
            Text("Class (changes are reflected thanks to @Published / @ObservedObject)")

            Text("Your name is \(user.firstName) \(user.lastName).")

            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
    }
}

struct ObservedObjects_Previews: PreviewProvider {
    static var previews: some View {
        ObservedObjects()
    }
}
