//
//  ValidatingForms.swift
//  Project15-Challenge1
//
//  Created by clarknt on 2019-11-13.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct ValidatingForms: View {
    @State var username = ""
    @State var email = ""

    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
            .disabled(disableForm)
        }
    }
}

struct ValidatingForms_Previews: PreviewProvider {
    static var previews: some View {
        ValidatingForms()
    }
}
