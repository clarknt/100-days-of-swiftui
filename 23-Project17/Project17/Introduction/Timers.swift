//
//  Timers.swift
//  Project17
//
//  Created by clarknt on 2020-01-03.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct Timers: View {
    // default tolerance (as accurate as possible but still "best-effort")
    //let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    // half a second tolerance
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()

    @State private var counter = 0

    var body: some View {
        Text("Hello, World!")
            .onReceive(timer) { time in
                if self.counter == 5 {
                    self.timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }

                self.counter += 1
            }
    }
}

struct Timers_Previews: PreviewProvider {
    static var previews: some View {
        Timers()
    }
}
