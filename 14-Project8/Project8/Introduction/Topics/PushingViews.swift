//
//  PushingViews.swift
//  Project8
//
//  Created by clarknt on 2019-11-01.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct PushingViews: View {
    var body: some View {
        // MainView already contains a NavigationView
//        NavigationView {
        List(0..<100) { row in
                NavigationLink(destination: Text("Detail View \(row)")) {
                    Text("Row \(row)")
                }
            }
            .navigationBarTitle("SwiftUI")
//        }
    }
}

struct PushingViews_Previews: PreviewProvider {
    static var previews: some View {
        PushingViews()
    }
}
