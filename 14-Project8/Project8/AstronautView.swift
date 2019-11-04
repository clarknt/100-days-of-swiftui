//
//  AstronautView.swift
//  Project8
//
//  Created by clarknt on 2019-11-04.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                        // fix what seems like a SwiftUI bug where on certain devices
                        // (like the iPhone 11 Pro Max) and certain astronauts (like
                        // Edward H. White II from Apollo 1) the text would be truncated,
                        // and the image pushed down views default layout priority is 0.
                        // giving it 1 gives it a higher priority than other views to grow
                        // or shrink. it'll then take up all available space
                        .layoutPriority(1)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
