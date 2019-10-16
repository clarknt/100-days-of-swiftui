//
//  BehindTheMainSwiftView.swift
//  Project3
//
//  Created by clarknt on 2019-10-16.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct BehindTheMainSwiftView: View {
    var body: some View {
        Text("Hello World")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.red)
            .edgesIgnoringSafeArea(.all)
    }
}

struct BehindTheMainSwiftView_Previews: PreviewProvider {
    static var previews: some View {
        BehindTheMainSwiftView()
    }
}
