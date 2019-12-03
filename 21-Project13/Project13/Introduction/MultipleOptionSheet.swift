//
//  MultipleOptionSheet.swift
//  Project13
//
//  Created by clarknt on 2019-12-02.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct MultipleOptionSheet: View {
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white

    var body: some View {
        Text("Hello, World!")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
                .default(Text("Red"), action: { self.backgroundColor = .red }),
                .default(Text("Green"), action: { self.backgroundColor = .green }),
                .default(Text("Blue"), action: { self.backgroundColor = .blue }),
                .cancel()
            ])
        }
    }
}

struct MultipleOptionSheet_Previews: PreviewProvider {
    static var previews: some View {
        MultipleOptionSheet()
    }
}
