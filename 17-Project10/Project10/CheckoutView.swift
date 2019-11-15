//
//  CheckoutView.swift
//  Project10
//
//  Created by clarknt on 2019-11-14.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order

    var body: some View {
        Text("Hello, World!")
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
