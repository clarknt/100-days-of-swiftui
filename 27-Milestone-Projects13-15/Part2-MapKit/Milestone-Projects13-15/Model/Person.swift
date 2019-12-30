//
//  Person.swift
//  Milestone-Projects13-15
//
//  Created by clarknt on 2019-12-17.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation
import CoreLocation

struct Person: Codable, Identifiable {
    var id = UUID()
    var name: String
    var imagePath: String?

    var locationRecorded = false

    /// Valid only if locationRecorded is true
    var latitude: Double = 0

    /// Valid only if locationRecorded is true
    var longitude: Double = 0

    /// image is image data in any format
    mutating func setImage(image: Data) {
        imagePath = ImageUtils().setImage(image: image)
    }

    func getImage() -> Data? {
        return ImageUtils().getImage(imagePath: imagePath)
    }

    mutating func deleteImage() {
        ImageUtils().deleteImage(imagePath: imagePath)
        imagePath = nil
    }
}

extension Person: Equatable {

    static func ==(lhs: Person, rhs: Person) -> Bool {
        lhs.id == rhs.id
    }
}
