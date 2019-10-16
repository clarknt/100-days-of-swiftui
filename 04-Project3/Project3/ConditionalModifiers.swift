//
//  ConditionalModifiers.swift
//  Project3
//
//  Created by clarknt on 2019-10-16.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct ConditionalModifiers: View {
    @State private var useRedText = false

    var body: some View {
        Button("Hello World") {
            // flip the Boolean between true and false
            self.useRedText.toggle()
        }
        .foregroundColor(useRedText ? .red : .blue)
    }
}

// not allowed because 2 views returned are of different types
//struct IncorrectView: View {
//    var body: some View {
//        if self.useRedText {
//            return Text("Hello World")
//        } else {
//            return Text("Hello World")
//                .background(Color.red)
//        }
//    }
//}

struct ConditionalModifiers_Previews: PreviewProvider {
    static var previews: some View {
        ConditionalModifiers()
    }
}
