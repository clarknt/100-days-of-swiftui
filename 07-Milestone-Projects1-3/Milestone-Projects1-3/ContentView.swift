//
//  ContentView.swift
//  Milestone-Projects1-3
//
//  Created by clarknt on 2019-10-18.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI
import Combine

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

enum Mode: CaseIterable {
    case normal
    case timed
}

struct ContentView: View {
    @State private var game = RockPaperScissors()
    @State private var score = 0

    static private let maxTime = 5.0
    @State private var remainingTime = ContentView.maxTime
    @State private var gameMode: Mode = .normal

    private static var timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()

    var body: some View {
        VStack {
            Button(action: {
                self.gameMode = (self.gameMode == .normal ? .timed : .normal)
                self.newQuestion()
            }, label: {
                Text(gameMode == .normal ? "Untimed game" : "Timed game, remaining \(remainingTime, specifier: "%.0f")s")
                    .padding()
            })
            .onReceive(ContentView.timer) { _ in
                self.updateTime()
            }

            GestureView(gesture: game.gesture)
                .font(Font.system(size: 100))

            GoalView(goal: game.goal)
                .padding(.top)

            HStack {
                ForEach(Gesture.allCases, id: \.self) { gesture in
                    Button(action: {
                        self.submitAnswer(withGuess: gesture)
                    }, label: {
                        GestureView(gesture: gesture)
                            .font(Font.system(size: 50))
                            .padding()
                    })
                }
            }

            HStack {
                Text("Score")
                Text(String(score))
                    .font(.largeTitle)
            }
        }
    }

    private func updateTime() {
        if gameMode == .timed {
            remainingTime -= 1

            if remainingTime <= 0 {
                updateScore(withWin: false)
            }
        }
    }

    private func submitAnswer(withGuess guess: Gesture) {
        let win = self.game.isCorrect(guess: guess)
        self.updateScore(withWin: win)
    }

    private func updateScore(withWin win: Bool) {
        score += win ? 1 : -1
        newQuestion()
    }

    private func newQuestion() {
        game = RockPaperScissors()
        remainingTime = ContentView.maxTime
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
