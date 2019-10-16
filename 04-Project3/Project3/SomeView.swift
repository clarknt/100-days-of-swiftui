//
//  SomeView.swift
//  Project3
//
//  Created by clarknt on 2019-10-16.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct SomeView: View {
    var body: some View {
        VStack {
            Spacer()

            TextView()

            Spacer()

            ButtonView()

            Spacer()

            ComplexButtonView()

            Spacer()
        }
    }
}

struct TextView: View {
    var body: Text {
        Text(/*@START_MENU_TOKEN@*/"Hello World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ButtonView: View {
    var body: some View {
        Button("Hello World") {
            print(type(of: self.body))
        }
        .frame(width: 200, height: 200)
        .background(Color.red)
    }
}

struct ComplexButtonView: View {
    var body: ModifiedContent<ModifiedContent<Button<Text>, _FrameLayout>, _BackgroundModifier<Color>> {
        Button("Hello World") {
            print(type(of: self.body))
        }
        .frame(width: 200, height: 200)
        .background(Color.red)
        as! ModifiedContent<ModifiedContent<Button<Text>, _FrameLayout>, _BackgroundModifier<Color>>
    }
}




struct SomeView_Previews: PreviewProvider {
    static var previews: some View {
        SomeView()
    }
}
