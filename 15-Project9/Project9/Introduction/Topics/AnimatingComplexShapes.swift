//
//  AnimatingComplexShapes.swift
//  Project9
//
//  Created by clarknt on 2019-11-07.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct CheckerBoard: Shape {
    var rows: Int
    var columns: Int

    public var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }

        set {
            self.rows = Int(newValue.first)
            self.columns = Int(newValue.second)
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let rowSize = rect.height / CGFloat(rows)
        let columnSize = rect.width / CGFloat(columns)

        for row in 0..<rows {
            for column in 0..<columns {
                // colored squares
                if (row + column).isMultiple(of: 2) {
                    let startX = columnSize * CGFloat(column)
                    let startY = rowSize * CGFloat(row)

                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }

        return path
    }
}

struct AnimatingComplexShapes: View {
    @State private var rows = 4
    @State private var columns = 4

    var body: some View {
        CheckerBoard(rows: rows, columns: columns)
            // note: tap works on even squares only, the rest being empty space
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    self.rows = 8
                    self.columns = 16
                }
        }
        .navigationBarTitle("Animating complex shapes", displayMode: .inline)
    }
}

struct AnimatingComplexShapes_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingComplexShapes()
    }
}
