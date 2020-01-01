//
//  ImageInterpolation.swift
//  Project16
//
//  Created by clarknt on 2019-12-22.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct ImageInterpolation: View {
    var body: some View {
        Image("example")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ImageInterpolation_Previews: PreviewProvider {
    static var previews: some View {
        ImageInterpolation()
    }
}
