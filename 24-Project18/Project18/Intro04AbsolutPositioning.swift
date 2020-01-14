//
//  Intro04AbsolutPositioning.swift
//  Project18
//
//  Created by clarknt on 2020-01-13.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct Intro04AbsolutPositioning: View {
    var body: some View {
        TabView {
            Text("Hello, World!")
                .background(Color.blue)
                .position(x: 100, y: 100)
                .background(Color.red)
                .tabItem { Text("Position") }

            Text("Offsetted position")
                .border(Color.yellow)
                .offset(x: 50, y: 50) // applies to all above
                .border(Color.green)
                .offset(x: 100, y: 100) // applies to all above
                .background(Color.red)
                .offset(x: -75, y: -75) // applies to all above
                .background(Text("Original position"))
                .tabItem { Text("Offset") }
        }
    }
}

struct Intro04AbsolutPositioning_Previews: PreviewProvider {
    static var previews: some View {
        Intro04AbsolutPositioning()
    }
}
