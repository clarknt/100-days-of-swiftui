//
//  ContentView.swift
//  Milestone-Projects1-3
//
//  Created by clarknt on 2019-10-18.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct GestureView: View {
    var gesture: Gesture

    var body: some View {
        switch gesture {
        case .rock:
            return Text("✊")
        case .paper:
            return Text("✋")
        case .scissors:
            return Text("✌️")
        }
    }
}

struct GoalView: View {
    var goal: Goal

    var body: some View {
        HStack {
            Text("How to")
            if goal == .win {
                Text("win")
                    .foregroundColor(.green)
            }
            else {
                Text("lose")
                    .foregroundColor(.red)
            }
            Text("this game?")
        }
    }
}

struct ContentView: View {
    @ObservedObject private var game = RockPaperScissors()

    var body: some View {
        VStack {
            Button(action: {
                self.game.mode = (self.game.mode == .normal ? .timed : .normal)
            }, label: {
                Text(game.mode == .normal ? "Untimed game" : "Timed game, remaining \(game.remainingTime, specifier: "%.0f")s")
                    .padding()
            })

            GestureView(gesture: game.gesture)
                .font(Font.system(size: 100))

            GoalView(goal: game.goal)
                .padding(.top)

            HStack {
                ForEach(Gesture.allCases, id: \.self) { gesture in
                    Button(action: {
                        self.game.submitAnswer(withGuess: gesture)
                    }, label: {
                        GestureView(gesture: gesture)
                            .font(Font.system(size: 50))
                            .padding()
                    })
                }
            }

            HStack {
                Text("Score")
                Text(String(game.score))
                    .font(.largeTitle)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
