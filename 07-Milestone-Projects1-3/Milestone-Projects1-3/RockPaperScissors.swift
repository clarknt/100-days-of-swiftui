//
//  RockPaperScissors.swift
//  Milestone-Projects1-3
//
//  Created by clarknt on 2019-10-18.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

enum Gesture: CaseIterable {
    case rock
    case paper
    case scissors
}

enum Goal: CaseIterable {
    case win
    case lose
}

struct RockPaperScissors {
    var gesture: Gesture = Gesture.allCases.randomElement()!
    var goal = Goal.allCases.randomElement()!

    func result() -> Gesture {
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
