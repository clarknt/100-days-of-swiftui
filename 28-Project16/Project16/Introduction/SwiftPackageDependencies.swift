//
//  SwiftPackageDependencies.swift
//  Project16
//
//  Created by clarknt on 2019-12-23.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SamplePackage
import SwiftUI

struct SwiftPackageDependencies: View {
    let possibleNumbers = Array(1...60)

    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }

    var body: some View {
        Text(results)
    }
}

struct SwiftPackageDependencies_Previews: PreviewProvider {
    static var previews: some View {
        SwiftPackageDependencies()
    }
}
