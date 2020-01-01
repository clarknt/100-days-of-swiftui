//
//  ContextMenus.swift
//  Project16
//
//  Created by clarknt on 2019-12-22.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct ContextMenus: View {
    @State private var backgroundColor = Color.red

    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .background(backgroundColor)

            Text("Change color")
                .padding()
                .contextMenu {
                    Button(action: {
                        self.backgroundColor = .red
                    }) {
                        Text("Red")
                        // can't really use actual images here because they are
                        // rendered as a solid color where the opacity is preserved
                        // an image without transparency would be just a black square
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.red) // ignored
                     }

                Button(action: {
                    self.backgroundColor = .green
                }) {
                    Text("Green")
                }

                Button(action: {
                    self.backgroundColor = .blue
                }) {
                    Text("Blue")
                }
            }
        }
    }
}

struct ContextMenus_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenus()
    }
}
