//
//  CreativeBorders.swift
//  Project9
//
//  Created by clarknt on 2019-11-06.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct CreativeBorders: View {
    @State var selectedView = 0

    var body: some View {
        TabView(selection: $selectedView) {

            Group {
                Text("Hello, World!")
                    .frame(width: 300, height: 300)
                    //.background(Image("Example"))
                    .background(Image("Example"))
            }
            .tabItem {
                Image(systemName: "1.circle")
                Text("Image background")
            }
            .tag(0)

            Group {
                Text("Hello, World!")
                    .frame(width: 300, height: 300)
                    //.background(Image("Example"))
                    .border(ImagePaint(image: Image("Example"), scale: 0.2), width: 30)
            }
            .tabItem {
                Image(systemName: "2.circle")
                Text("Image border 1")
            }
            .tag(1)

            Group {
                Text("Hello, World!")
                    .frame(width: 300, height: 300)
                    //.background(Image("Example"))
                    .border(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)
            }
            .tabItem {
                Image(systemName: "3.circle")
                Text("Image border 2")
            }
            .tag(2)

            Group {
                Capsule()
                .strokeBorder(ImagePaint(image: Image("Example"), scale: 0.1), lineWidth: 20)
                .frame(width: 300, height: 200)
            }
            .tabItem {
                Image(systemName: "4.circle")
                Text("Capsule image border")
            }
            .tag(3)
        }
        .navigationBarTitle("Creative borders", displayMode: .inline)
    }
}

struct CreativeBorders_Previews: PreviewProvider {
    static var previews: some View {
        CreativeBorders()
    }
}
