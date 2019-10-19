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
    @Published var timerValue = RockPaperScissors.maxTime

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
                timerValue = RockPaperScissors.maxTime
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                    // note: because of this it is not possible to make RockPaperScissors a
                    // struct (which would have no need for ObservableObject, @Published and
                    // could be used as @State instead of @ObservedObject)
                    // indeed updateTime() is mutating; as a struct the Timer would only
                    // have a copy of self and would not be able to mutate the original struct
                    self?.updateTime()
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
            score += guess == result() ? 1 : -1
        case .timed:
            score += timerValue > 0 && guess == result() ? 1 : -1
        }
    }

    private func updateTime() {
        if mode == .timed {
            timerValue -= 1

            if timerValue <= 0 {
                score -= 1
            }
        }
    }

    private func newQuestion() {
        gesture = Gesture.allCases.randomElement()!
        goal = Goal.allCases.randomElement()!

        if mode == .timed {
            timerValue = RockPaperScissors.maxTime
        }
    }

    private func result() -> Gesture {
        switch goal {
        case .win:
            return winner()
        case .lose:
            return loser()
        }
    }

    private func winner() -> Gesture {
        switch gesture {
        case .rock:
            return .paper
        case .paper:
            return .scissors
        case .scissors:
            return .rock
        }
    }

    private func loser() -> Gesture {
        switch gesture {
        case .rock:
            return .scissors
        case .paper:
            return .rock
        case .scissors:
            return .paper
        }
    }
}
