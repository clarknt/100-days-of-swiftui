//
//  SettingsView.swift
//  Project17
//
//  Created by clarknt on 2020-01-08.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

// Challenge 2
struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var retryIncorrectCards: Bool

    var body: some View {
        NavigationView {
            Form {
                Section(footer: Text("Cards for which you did not know the answer will go back to the end of the stack")) {
                    Toggle(isOn: $retryIncorrectCards) {
                        Text("Retry incorrect cards")
                    }
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done", action: dismiss))
        }
    }

    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(retryIncorrectCards: Binding.constant(false))
    }
}
