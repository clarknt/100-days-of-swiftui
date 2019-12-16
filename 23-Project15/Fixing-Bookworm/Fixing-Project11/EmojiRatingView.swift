//
//  EmojiRatingView.swift
//  Fixing-Project11
//
//  Created by clarknt on 2019-11-18.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int16

    var body: some View {
        switch rating {
        case 1:
            return Image(systemName: "cloud.rain.fill")
                .foregroundColor(Color.red.opacity(0.2))
        case 2:
            return Image(systemName: "cloud.fill")
                .foregroundColor(Color.red.opacity(0.4))
        case 3:
            return Image(systemName: "cloud.sun.fill")
                .foregroundColor(Color.orange.opacity(0.6))
        case 4:
            return Image(systemName: "sun.min.fill")
                .foregroundColor(Color.yellow.opacity(0.8))
        default:
            return Image(systemName: "sun.max.fill")
                .foregroundColor(Color.yellow.opacity(1))
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 3)
    }
}
