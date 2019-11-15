//
//  CheckoutView.swift
//  Project10
//
//  Created by clarknt on 2019-11-14.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

enum AlertType {
    case confirmation
    case error
}

struct CheckoutView: View {
    // challenge 3
    @ObservedObject var oo: ObservableOrder

    @State private var confirmationMessage = ""

    // challenge 2
    @State private var showingAlert = false
    @State private var errorMessage = ""
    @State var alertType = AlertType.confirmation

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text("Your total is $\(self.oo.order.cost, specifier: "%.2f")")
                        .font(.title)

                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        // challenge 2
        .alert(isPresented: $showingAlert) { () -> Alert in
            switch alertType {
            case .confirmation:
                return Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
            case .error:
                return Alert(title: Text("Error!"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(oo.order) else {
            // challenge 2
            self.show(error: "Failed to encode order")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                // challenge 2
                self.show(error: "No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                // challenge 2
                self.show(confirmation: "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!")
            }
            else {
                // challenge 2
                self.show(error: "Invalid response from server")
            }
        }.resume()
    }

    // challenge 2
    func show(error: String) {
        self.errorMessage = error
        self.alertType = .error
        self.showingAlert = true
    }

    // challenge 2
    func show(confirmation: String) {
        self.confirmationMessage = confirmation
        self.alertType = .confirmation
        self.showingAlert = true
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        // challenge 3
        CheckoutView(oo: ObservableOrder(order: Order()))
    }
}
