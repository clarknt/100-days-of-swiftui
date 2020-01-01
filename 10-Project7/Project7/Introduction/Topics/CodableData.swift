//
//  CodableData.swift
//  Project7
//
//  Created by clarknt on 2019-10-30.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct CodableUser: Codable {
    var firstName: String
    var lastName: String
}

struct CodableData: View {
    static private let userKey = "UserData"

    @State private var user = CodableUser(firstName: "Taylor", lastName: "Swift")

    var body: some View {
        VStack {
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)

            Button("Save User") {
                let encoder = JSONEncoder()

                if let data = try? encoder.encode(self.user) {
                    UserDefaults.standard.set(data, forKey: Self.userKey)
                }
            }
        }
        .onAppear(perform: loadUser)
    }

    func loadUser() {
        if let encodedUser = UserDefaults.standard.data(forKey: Self.userKey) {
            let decoder = JSONDecoder()

            if let tmpUser = try? decoder.decode(CodableUser.self, from: encodedUser) {
                user = tmpUser
            }
        }
    }
}

struct CodableData_Previews: PreviewProvider {
    static var previews: some View {
        CodableData()
    }
}
