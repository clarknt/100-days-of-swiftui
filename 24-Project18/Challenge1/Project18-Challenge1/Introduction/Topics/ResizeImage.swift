//
//  ResizeImage.swift
//  Project18-Challenge1
//
//  Created by clarknt on 2019-11-01.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct ResizeImage: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Image("swift")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width) // height is deduced from original width, target width and aspect ratio
            }
        }
    }
}

struct ResizeImage_Previews: PreviewProvider {
    static var previews: some View {
        ResizeImage()
    }
}
