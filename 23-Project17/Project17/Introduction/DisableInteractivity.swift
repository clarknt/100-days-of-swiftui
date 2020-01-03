//
//  DisableInteractivity.swift
//  Project17
//
//  Created by clarknt on 2020-01-02.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct DisableInteractivity: View {
    var body: some View {
        TabView {
            ZStack {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 300, height: 300)
                    .onTapGesture {
                        print("Rectangle tapped!")
                    }

                Circle()
                    .fill(Color.red)
                    .frame(width: 300, height: 300)
                    .onTapGesture {
                        print("Circle tapped!")
                    }
            }
            .tabItem {
                Image(systemName: "1.circle")
                Text("Circle+rectangle")
            }

            ZStack {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 300, height: 300)
                    .onTapGesture {
                        print("Rectangle tapped!")
                    }

                Circle()
                    .fill(Color.red)
                    .frame(width: 300, height: 300)
                    .onTapGesture {
                        print("Circle tapped!")
                    }
                    .allowsHitTesting(false)
            }
            .tabItem {
                Image(systemName: "2.circle")
                Text("Rectangle")
            }

            ZStack {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 300, height: 300)
                    .onTapGesture {
                        print("Rectangle tapped!")
                    }

                Circle()
                    .fill(Color.red)
                    .frame(width: 300, height: 300)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        print("Circle tapped!")
                    }
            }
            .tabItem {
                Image(systemName: "3.circle")
                Text("Circle")
            }

            HStack {
                VStack {
                    Text("Can't")
                    Spacer().frame(height: 100)
                    Text("tap")
                    Spacer().frame(height: 100)
                    Text("space")
                }
                .onTapGesture {
                    print("VStack tapped!")
                }

                Spacer()

                VStack {
                    Text("Can")
                    Spacer().frame(height: 100)
                    Text("tap")
                    Spacer().frame(height: 100)
                    Text("space")
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    print("VStack tapped!")
                }
            }
            .tabItem {
                Image(systemName: "4.circle")
                Text("Text")
            }
        }
    }
}

struct DisableInteractivity_Previews: PreviewProvider {
    static var previews: some View {
        DisableInteractivity()
    }
}
