//
//  CoreImageSwiftUI.swift
//  Project13
//
//  Created by clarknt on 2019-12-03.
//  Copyright © 2019 clarknt. All rights reserved.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct CoreImageSwiftUI: View {
    @State private var image: Image?
    @State private var showingAlert = false

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        // attach to VStack, not image otherwise it won't be triggered
        // by a nil image
        .onAppear(perform: loadImage)
        .onTapGesture { self.showingAlert = true }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Image by Jude Arubi (@judearubi) on Unsplash.com"))
        }
    }

    func loadImage() {
        // UIImage
        guard let inputImage = UIImage(named: "photo-1575323653947-b92f5215407c") else { return }

        // CIImage
        let beginImage = CIImage(image: inputImage)

        // apply filter
        // effect 1
//        let currentFilter = CIFilter.sepiaTone()
//        currentFilter.inputImage = beginImage
//        currentFilter.intensity = 1

        // effect 2
//        let currentFilter = CIFilter.pixellate()
//        currentFilter.inputImage = beginImage
//        currentFilter.scale = 10

        // effect 3 - crashing (Apple's fault)
//        let currentFilter = CIFilter.crystallize()
//        currentFilter.inputImage = beginImage
//        currentFilter.radius = 200

        // effect 3 - workaround
//        let currentFilter = CIFilter.crystallize()
//        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//        currentFilter.radius = 50

        // effect 4
        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(500, forKey: kCIInputRadiusKey)
        currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2), forKey: kCIInputCenterKey)

        // CIImage
        guard let outputImage = currentFilter.outputImage else { return }

        let context = CIContext()
        // CGImage
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }

        // UIImage
        let uiImage = UIImage(cgImage: cgImage)

        // Image
        image = Image(uiImage: uiImage)
    }

}

struct CoreImageSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        CoreImageSwiftUI()
    }
}
