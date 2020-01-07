//
//  CardView.swift
//  Project17
//
//  Created by clarknt on 2020-01-07.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct CardView: View {
    let card: Card

    @State private var isShowingAnswer = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .shadow(radius: 10)

            VStack {
                Text(card.prompt)
                    .font(.largeTitle)

                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.secondary)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        // smallest iPhones have a landscape width of 480 points
        .frame(width: 450, height: 250)
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
            .previewLayout(.fixed(width: 568, height: 320)) // iPhone SE landscape size
    }
}
