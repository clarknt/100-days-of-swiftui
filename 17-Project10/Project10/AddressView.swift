//
//  AddressView.swift
//  Project10
//
//  Created by clarknt on 2019-11-14.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    // challenge 3
    @ObservedObject var oo: ObservableOrder

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $oo.order.name)
                TextField("Street Address", text: $oo.order.streetAddress)
                TextField("City", text: $oo.order.city)
                TextField("Zip", text: $oo.order.zip)

            }

            Section {
                NavigationLink(destination: CheckoutView(oo: oo)){
                    Text("Checkout")
                }
                .disabled(oo.order.hasValidAddress == false)
            }
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        // challenge 3
        AddressView(oo: ObservableOrder(order: Order()))
    }
}
