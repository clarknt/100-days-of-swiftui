//
//  Settings.swift
//  Milestone-Projects4-6
//
//  Created by clarknt on 2019-11-01.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

enum NumberOfQuestions: String, CaseIterable {
    case five = "5"
    case ten = "10"
    case twenty = "20"
    case all = "All"
}

class Settings: ObservableObject {
    @Published var tablesUpTo = 1

    @Published var numberOfQuestionsIndex = 0
    var numbersOfQuestions = NumberOfQuestions.allCases

    var numberOfQuestions: Int {
        if let number = Int(numbersOfQuestions[numberOfQuestionsIndex].rawValue) {
            return number
        }

        return maxNumberOfQuestions
    }

    var maxNumberOfQuestions: Int {
        // example with tables up to 3:
        // 1x1, 1x2, 1x3, 1x4, 1x5, 1x6, 1x7, 1x8, 1x9, 1x10, 1x11, 1x12
        //      2x1, 3x1, 4x1, 5x1, 6x1, 7x1, 8x1, 9x1, 10x1, 11x1, 12x1 =>  23
        //      2x2, 2x3, 2x4, 2x5, 2x6, 2x7, 2x8, 2x9, 2x10, 2x11, 2x12
        //           3x2, 4x2, 5x2, 6x2, 7x2, 8x2, 9x2, 10x2, 11x2, 12x2 => +21 = 44
        //           3x3, 3x4, 3x5, 3x6, 3x7, 3x8, 3x9, 3x10, 3x11, 3x12
        //                4x3, 5x3, 6x3, 7x3, 8x3, 9x3, 10x3, 11x3, 12x3 => +19 = 63

        var duplicates = 0
        for i in 1...tablesUpTo {
            // 1: duplicates within current table (1x1, 2x2, etc)
            // (i - 1) * 2: duplicates of previous tables (table of 2: 1x2, 2x1, table of 3: 1x3, 3x1, 2x3, 3x2)
            duplicates += 1 + (i - 1) * 2
        }

        return tablesUpTo * 24 - duplicates
    }
}
