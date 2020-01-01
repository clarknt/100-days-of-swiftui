//
//  ImageSaver.swift
//  Project13
//
//  Created by clarknt on 2019-12-04.
//  Copyright © 2019 clarknt. All rights reserved.
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?

    func writePhotoToAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        // save complete
        if let error = error {
            errorHandler?(error)
        }
        else {
            successHandler?()
        }
    }
}
