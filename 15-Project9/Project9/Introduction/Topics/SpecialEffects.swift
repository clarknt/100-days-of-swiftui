//
//  SpecialEffects.swift
//  Project9
//
//  Created by clarknt on 2019-11-07.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct MultiplyBlend: View {
    var body: some View {
        ZStack {
            // Photo by Olivia Hutcherson on Unsplash https://unsplash.com/photos/JtVkmKQ1FQI
            Image("olivia-hutcherson-JtVkmKQ1FQI-unsplash")
                .resizable()
                .aspectRatio(contentMode: .fit)

            Rectangle()
                .fill(Color.red)
                .blendMode(.multiply)
        }
        .frame(width: 400, height: 500)
        .clipped()
    }
}

struct Circles: View {
    @State private var amount: CGFloat = 0.75

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color(red: 1, green: 0, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)

                Circle()
                    .fill(Color(red: 0, green: 1, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)

                Circle()
                    .fill(Color(red: 0, green: 0, blue: 1))
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
            }
            .frame(width: 300, height: 300)

            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct BlurSaturation: View {
    @State private var amount: CGFloat = 0.75

    var body: some View {
        VStack {
            // Photo by Olivia Hutcherson on Unsplash https://unsplash.com/photos/JtVkmKQ1FQI
            Image("olivia-hutcherson-JtVkmKQ1FQI-unsplash")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .saturation(Double(amount))
                .blur(radius: (1 - amount) * 10)

            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SpecialEffects: View {
    @State private var selectedView = 0
    let views = ["Multiply", "Screen", "BlurSaturation"]

    var body: some View {
        VStack {
            Picker("Effect", selection: $selectedView) {
                ForEach(0..<views.count, id: \.self) { i in
                    Text(self.views[i])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Spacer()

            if selectedView == 0 {
                MultiplyBlend()
            }
            else if selectedView == 1 {
                Circles()
            }
            else {
                BlurSaturation()
            }
        }
        .navigationBarTitle("Special effects", displayMode: .inline)
    }
}

struct SpecialEffects_Previews: PreviewProvider {
    static var previews: some View {
        SpecialEffects()
    }
}
