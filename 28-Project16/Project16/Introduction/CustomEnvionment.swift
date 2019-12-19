//
//  CustomEnvionmnet.swift
//  Project16
//
//  Created by clarknt on 2019-12-19.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User

    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User

    var body: some View {
        Text(user.name)
    }
}

struct CustomEnvionment: View {
    let user = User()

    var body: some View {
        VStack {
            EditView()
            DisplayView()
        }
        .environmentObject(user)
    }
}

struct CustomEnvionmnet_Previews: PreviewProvider {
    static var previews: some View {
        CustomEnvionment()
    }
}
