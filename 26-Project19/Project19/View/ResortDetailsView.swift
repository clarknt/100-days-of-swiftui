//
//  ResortDetailsView.swift
//  Project19
//
//  Created by clarknt on 2020-01-31.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort

    var body: some View {
        Group {
            Text("Size: \(resort.sizeText)").layoutPriority(1)
            Spacer().frame(height: 0)
            Text("Price: \(resort.priceText)").layoutPriority(1)
        }
    }
}

struct ResortDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: Resort.example)
    }
}
