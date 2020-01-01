//
//  DetailView.swift
//  Milestone-Projects10-12
//
//  Created by clarknt on 2019-11-27.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var user: User

    var body: some View {
        List {
            Section(header: Text("Name")) {
                Text(user.uwName)
            }
            Section(header: Text("Age")) {
                Text(String(user.age))
            }
            Section(header: Text("Company")) {
                Text(user.uwCompanyName)
            }
            Section(header: Text("Email")) {
                Text(user.uwEmail)
            }
            Section(header: Text("Address")) {
                Text(user.uwAddress)
            }
            Section(header: Text("Friends")) {
                ForEach(user.friendsArray, id: \.id) { friend in
                    NavigationLink(destination: DetailView(user: friend)) {
                        VStack(alignment: HorizontalAlignment.leading) {
                            Text(friend.uwName)
                                .font(.headline)
                            Text(friend.uwEmail)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("\(user.uwName)", displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {

    static var john: User {
        let user = User()
        user.name = "John Smith"
        user.age = 54
        user.email = "john.smith@apple.com"
        user.address = "Cupertino"

        let company = Company()
        company.name = "Apple"
        user.company = company

        return user
    }

    static var previews: some View {
        DetailView(user: john)
    }
}
