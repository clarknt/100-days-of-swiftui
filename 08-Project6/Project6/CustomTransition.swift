//
//  CustomTransition.swift
//  Project6
//
//  Created by clarknt on 2019-10-27.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor)
            .clipped() // when the view rotates, the parts that are lying outside its natural rectangle don’t get drawn
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct CustomTransition: View {
    @State private var isShowingRed = false

    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    self.isShowingRed.toggle()
                }
            }

            // optional (in comments): keep the space between the button at all time
            //ZStack {
            //    Rectangle()
            //        .fill(Color.init(red: 0, green: 0, blue: 0).opacity(0))
            //        .frame(width: 200, height: 200)

                if isShowingRed {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 200, height: 200)
                        .transition(.pivot)
                }
            //}
        }
    }
}

struct CustomTransition_Previews: PreviewProvider {
    static var previews: some View {
        CustomTransition()
    }
}
