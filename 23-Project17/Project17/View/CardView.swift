//
//  CardView.swift
//  Project17
//
//  Created by clarknt on 2020-01-07.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    // closest option SwiftUI gives us to “VoiceOver Running”
    @Environment(\.accessibilityEnabled) var accessibilityEnabled

    let card: Card

    // Challenge 1
    var removal: ((_ isCorrect: Bool) -> Void)?

    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? Color.white
                        : Color.white
                            .opacity(1 - Double(abs(offset.width / 50)))

                )
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(offset.width > 0 ? Color.green : Color.red)
                )
                .shadow(radius: 10)
            
            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(Color.black)
                }
                else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        // force black otherwise it's white on white in dark mode
                        .foregroundColor(Color.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            // force grey otherwise it's light gray on white in dark mode
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        // smallest iPhones have a landscape width of 480 points
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        // start at 2 to keep it opaque until reaching 50 points
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibility(addTraits: .isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                    // warm up taptic engine to avoid delay when playing haptic feedback
                    self.feedback.prepare()
                }
                .onEnded { _ in
                    if abs(self.offset.width) > 100 {
                        // remove the card
                        if self.offset.width > 0 {
                            self.feedback.notificationOccurred(.success)
                        } else {
                            self.feedback.notificationOccurred(.error)
                        }

                        // Challenge 1
                        self.removal?(self.offset.width > 0)
                    }
                    else {
                        // restore the card
                        self.offset = .zero
                    }
                }
        )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
        .animation(.spring())
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
            .previewLayout(.fixed(width: 568, height: 320)) // iPhone SE landscape size
    }
}
