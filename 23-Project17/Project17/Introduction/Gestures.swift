//
//  Gestures.swift
//  Project17
//
//  Created by clarknt on 2020-01-01.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct Gestures: View {

    var body: some View {
        TabView {
            GesturesPresses()
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Presses")
                }

            GesturesZoom()
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Zoom")
                }

            GesturesRotate()
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Rotate")
                }

            GesturesPriority()
                .tabItem {
                    Image(systemName: "4.circle")
                    Text("Priority")
                }

            GesturesSequence()
                .tabItem {
                    Image(systemName: "5.circle")
                    Text("Sequence")
                }

        }
    }
}

struct GesturesPresses: View {
    var body: some View {
        VStack {
            Text("Double tap")
                .padding()
                .onTapGesture(count: 2) {
                    print("Double tapped!")
                }

            Text("Long press")
                .padding()
                .onLongPressGesture {
                    print("Long pressed!")
                }

            Text("Long press 2 seconds")
                .padding()
                .onLongPressGesture(minimumDuration: 2) {
                    print("Long pressed!")
                }

            Text("Long press events")
                .padding()
                .onLongPressGesture(minimumDuration: 1, pressing: { inProgress in
                    print("In progress: \(inProgress)!")
                }) {
                    print("Long pressed!")
                }
        }
        .font(.title)
    }
}

struct GesturesZoom: View {
    @State private var zoomCurrentAmount: CGFloat = 0
    @State private var zoomFinalAmount: CGFloat = 1

    var body: some View {
        Text("Zoom me")
            .font(.title)
            .scaleEffect(zoomFinalAmount + zoomCurrentAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged { amount in
                        self.zoomCurrentAmount = amount - 1
                    }
                    .onEnded { amount in
                        self.zoomFinalAmount += self.zoomCurrentAmount
                        self.zoomCurrentAmount = 0
                    }
            )
    }
}

struct GesturesRotate: View {
    @State private var rotationCurrentAmount: Angle = .degrees(0)
    @State private var rotationFinalAmount: Angle = .degrees(0)

    var body: some View {
        Text("Rotate me")
            .font(.title)
            .rotationEffect(rotationCurrentAmount + rotationFinalAmount)
            .gesture(
                RotationGesture()
                    .onChanged { angle in
                        self.rotationCurrentAmount = angle
                    }
                    .onEnded { angle in
                        self.rotationFinalAmount += self.rotationCurrentAmount
                        self.rotationCurrentAmount = .degrees(0)
                    }
            )
    }
}

struct GesturesPriority: View {

    var body: some View {
        VStack {
            VStack {
                Text("Text priority")
                    .onTapGesture {
                        print("Text tapped")
                    }
            }
            .padding()
            .onTapGesture {
                print("VStack tapped")
            }

            VStack {
                Text("VStack priority")
                    .onTapGesture {
                        print("Text tapped")
                    }
            }
            .padding()
            .highPriorityGesture(
                TapGesture()
                    .onEnded { _ in
                        print("VStack tapped")
                    }
            )

            VStack {
                Text("VStack and text priority")
                    .onTapGesture {
                        print("Text tapped")
                    }
            }
            .padding()
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        print("VStack tapped")
                    }
            )
        }
        .font(.title)
    }
}

struct GesturesSequence: View {
    // how far the circle has been dragged
    @State private var offset = CGSize.zero

    // where it is currently being dragged or not
    @State private var isDragging = false

    var body: some View {
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = DragGesture()
            .onChanged { value in self.offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    self.offset = .zero
                    self.isDragging = false
                }
            }

        // a long press gesture that enables isDragging
        let tapGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    self.isDragging = true
                }
            }

        // a combined gesture that forces the user to long press then drag
        let combined = tapGesture.sequenced(before: dragGesture)

        // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
        return VStack {
            Text("Long press then drag the circle")
                .padding()
                .font(.title)

            Circle()
                .fill(Color.red)
                .frame(width: 64, height: 64)
                .scaleEffect(isDragging ? 1.5 : 1)
                .offset(offset)
                .gesture(combined)
        }
    }
}


struct Gestures_Previews: PreviewProvider {
    static var previews: some View {
        Gestures()
    }
}
