//
//  Intro03LAyout.swift
//  Project18
//
//  Created by clarknt on 2020-01-11.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct Intro03CustomAlignment: View {
    @Binding var topic: Topics

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("1. Unaligned")
                    .frame(width: geometry.size.width)
                    .padding(.bottom, 50)

                HStack {
                    VStack {
                        Text("@twostraws")
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 64, height: 64)
                    }

                    VStack {
                        Text("Full name:")
                        Text("PAUL HUDSON")
                            .font(.largeTitle)
                    }
                }

                Text("2. Aligned")
                    .frame(width: geometry.size.width)
                    .padding(.top, 100)
                    .padding(.bottom, 50)

                HStack(alignment: .midAccountAndName) {
                    VStack {
                        Text("Some more text")
                        Text("@twostraws")
                            .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 64, height: 64)
                        Text("Some more text")
                    }

                    VStack {
                        Text("Some more text")
                        Text("Full name:")
                        Text("PAUL HUDSON")
                            .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                            .font(.largeTitle)
                    }
                }
            }
        }
        .onTapGesture(count: 2) { self.topic = .none }
    }
}

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct Intro03CustomAlignment_Previews: PreviewProvider {
    static var previews: some View {
        Intro03CustomAlignment(topic: .constant(.customAlignment))
    }
}
