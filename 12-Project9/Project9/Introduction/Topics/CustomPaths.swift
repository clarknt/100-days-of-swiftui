//
//  CustomPaths.swift
//  Project9
//
//  Created by clarknt on 2019-11-05.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct CustomPaths: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.addLine(to: CGPoint(x: 200, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 300))
        }
        .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
        .navigationBarTitle("Custom paths", displayMode: .inline)
    }
}

struct CustomPaths_Previews: PreviewProvider {
    static var previews: some View {
        CustomPaths()
    }
}
