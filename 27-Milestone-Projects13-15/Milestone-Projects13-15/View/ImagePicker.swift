//
//  ImagePicker.swift
//  Milestone-Projects13-15
//
//  Created by clarknt on 2019-12-24.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct ImagePicker {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
}

extension ImagePicker: UIViewControllerRepresentable {

    /// Creates a `UIViewController` instance to be presented.
    func makeUIViewController(context: Self.Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }


    /// Updates the presented `UIViewController` (and coordinator) to the latest
    /// configuration.
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Self.Context) {

    }

    /// `Coordinator` can be accessed via `Context`.
    func makeCoordinator() -> Self.Coordinator {
        Coordinator(self)
    }

    /// A type to coordinate with the `UIViewController`.
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        // UIImagePickerControllerDelegate
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = fixImageOrientation(for: uiImage)
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

        // UIImage does not handle orientation in a way that is suitable
        // for using in an Image. Force writing the image correctly oriented.
        // More info here: https://stackoverflow.com/questions/8915630
        private func fixImageOrientation(for image: UIImage) -> UIImage {
            UIGraphicsBeginImageContext(image.size)
            image.draw(at: .zero)
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return rotatedImage ?? image
        }
    }
}
