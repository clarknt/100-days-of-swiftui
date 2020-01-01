//
//  ShowHideViews.swift
//  Project7
//
//  Created by clarknt on 2019-10-29.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode

    var name: String

    var body: some View {
        VStack {
            Text("Hello, \(name)")

            Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }
            .offset(x: 0, y: 20)
        }
    }
}

struct ShowHideViews: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            self.showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "Second View")
        }
    }
}

struct ShowHideViews_Previews: PreviewProvider {
    static var previews: some View {
        ShowHideViews()
    }
}
