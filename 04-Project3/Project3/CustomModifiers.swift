//
//  CustomModifierw.swift
//  Project3
//
//  Created by clarknt on 2019-10-16.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

struct CustomModifiers: View {
    var body: some View {
        VStack {
            Spacer()

            Text("Hello World!")
                .titleStyle()

            Spacer()

            Color.blue
            .frame(width: 300, height: 200)
            .watermarked(with: "Hacking with Swift")

            Spacer()
        }
    }
}

struct CustomModifierw_Previews: PreviewProvider {
    static var previews: some View {
        CustomModifiers()
    }
}
