//
//  Challenge1.swift
//  Project3
//
//  Created by clarknt on 2019-10-16.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

// challenge 1
struct LargeTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

// challenge 1
extension View {
    func largeTitle() -> some View {
        self.modifier(LargeTitle())
    }
}

struct Challenge1: View {
    var body: some View {
        Text("Custom ViewModifier")
            .largeTitle()
    }
}

struct Challenge1_Previews: PreviewProvider {
    static var previews: some View {
        Challenge1()
    }
}
