//
//  RockPaperScissors.swift
//  Milestone-Projects1-3
//
//  Created by clarknt on 2019-10-18.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

/// Rock Paper Scissors game model
class RockPaperScissors: ObservableObject {
    @Published var gesture = Gesture.allCases.randomElement()!
    @Published var goal = Goal.allCases.randomElement()!

    private var timer: Timer?
    private static let maxTime = 5.0
    @Published var remainingTime = RockPaperScissors.maxTime

    @Published var score = 0 {
        didSet {
            newQuestion()
        }
    }

    @Published var mode: Mode = .normal {
        didSet {
            switch mode {
            case .normal:
                timer?.invalidate()
                timer = nil
            case .timed:
                remainingTime = RockPaperScissors.maxTime
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                    // note: because of this it is not possible to make RockPaperScissors a
                    // struct (which would have no need for ObservableObject, @Published and
                    // could be used as @State instead of @ObservedObject)
                    // indeed updateTime() is mutating; as a struct the Timer would only
                    // have a copy of self and would not be able to mutate the original struct
                    self?.updateRemainingTime()
                }
            }
            newQuestion()
        }
    }

    deinit {
        timer?.invalidate()
        timer = nil
    }

    func submitAnswer(withGuess guess: Gesture) {
        switch mode {
        case .normal:
            score += isCorrect(guess: guess) ? 1 : -1
        case .timed:
            score += remainingTime > 0 && isCorrect(guess: guess) ? 1 : -1
        }
    }

    private func updateRemainingTime() {
        if mode == .timed {
            remainingTime -= 1

            if remainingTime <= 0 {
                score -= 1
            }
        }
    }

    private func newQuestion() {
        gesture = Gesture.allCases.randomElement()!
        goal = Goal.allCases.randomElement()!

        if mode == .timed {
            remainingTime = RockPaperScissors.maxTime
        }
    }

    private func isCorrect(guess: Gesture) -> Bool {
        switch goal {
        case .win:
            return isWinner(guess, over: gesture)
        case .lose:
            return isWinner(gesture, over: guess)
        }
    }

    private func isWinner(_ shouldWin: Gesture, over shouldLose: Gesture) -> Bool {
        switch shouldWin {
        case .rock:
            return shouldLose == .scissors
        case .paper:
            return shouldLose == .rock
        case .scissors:
            return shouldLose == .paper
        }
    }
}
