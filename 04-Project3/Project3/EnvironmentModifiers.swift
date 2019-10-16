//
//  EnvironmentModifiers.swift
//  Project3
//
//  Created by clarknt on 2019-10-16.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct EnvironmentModifiers: View {
    var body: some View {
        VStack {
            Spacer()

            EnvironmentModifier()

            Spacer()

            RegularModifier()

            Spacer()
        }
    }
}

struct EnvironmentModifier: View {
    var body: some View {
        VStack {
            Text("Gryffindor")
                .font(.largeTitle) // will replace title with large title for this text
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
        }
        .font(.title) // will apply to all the other text
    }
}

struct RegularModifier: View {
    var body: some View {
        VStack {
            VStack {
                Text("Gryffindor")
                    .blur(radius: 0) // will remained blurred at 5; if 10 is specified instead of 0, would be blurred at 15.
                Text("Hufflepuff")
                Text("Ravenclaw")
                Text("Slytherin")
            }
            .blur(radius: 5) // will apply to all
            .font(.title)
        }
    }
}

struct EnvironmentModifiers_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentModifiers()
    }
}
