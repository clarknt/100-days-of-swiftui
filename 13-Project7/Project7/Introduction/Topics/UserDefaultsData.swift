//
//  UserDefaults.swift
//  Project7
//
//  Created by clarknt on 2019-10-30.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct UserDefaultsData: View {
    static private let tapKey = "Tap"

    @State private var tapCount = UserDefaults.standard.integer(forKey: Self.tapKey)

    var body: some View {
        Button("Tap Count: \(tapCount)") {
            self.tapCount += 1
            UserDefaults.standard.set(self.tapCount, forKey: Self.tapKey)
        }
    }
}

struct UserDefaults_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultsData()
    }
}
