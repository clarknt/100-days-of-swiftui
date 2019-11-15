//
//  AddressView.swift
//  Project10
//
//  Created by clarknt on 2019-11-14.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order

    var body: some View {
        Text("Hello, World!")
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
