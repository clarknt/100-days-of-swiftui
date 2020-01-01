//
//  UIViewControllerSwiftUI.swift
//  Project13
//
//  Created by clarknt on 2019-12-03.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

class ImageSaverIntroduction: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished")
    }
}

struct UIViewControllerSwiftUI: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePickerIntroduction(image: self.$inputImage)
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        let imageSaver = ImageSaverIntroduction()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
}

struct UIViewControllerSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerSwiftUI()
    }
}
