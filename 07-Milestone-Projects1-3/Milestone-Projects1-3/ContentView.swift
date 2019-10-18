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

struct ContentView: View {
    @State var game = RockPaperScissors()
    @State var score = 0

    static let availableTime = 5
    @State var remainingTime = ContentView.availableTime
    @State var timedGame = false

    var timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()

    var body: some View {
        VStack {
            Button(action: {
                self.timedGame = !self.timedGame
                self.resetGame()
            }, label: {
                Text(timedGame ? "Timed game, remaining \(remainingTime)s" : "Untimed game")
                    .padding()
            })
            .onReceive(timer) { _ in
                self.updateTime()
            }

            GestureView(gesture: game.gesture)
                .font(Font.system(size: 100))

            GoalView(goal: game.goal)
                .padding(.top)

            HStack {
                ForEach(Gesture.allCases, id: \.self) { gesture in
                    Button(action: {
                        let win = (gesture == self.game.result())
                        self.updateResult(withWin: win)
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

    func updateTime() {
        if timedGame {
            remainingTime -= 1
            if remainingTime <= 0 {
                updateResult(withWin: false)
            }
        }
    }

    func updateResult(withWin win: Bool) {
        score += win ? 1 : -1
        resetGame()
    }

    func resetGame() {
        game = RockPaperScissors()
        resetTime()
    }

    func resetTime() {
        self.remainingTime = ContentView.availableTime
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
