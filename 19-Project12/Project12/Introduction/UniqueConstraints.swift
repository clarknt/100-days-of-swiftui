//
//  UniqueConstraints.swift
//  Project12
//
//  Created by clarknt on 2019-11-20.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct UniqueConstraints: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>

    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }

            Button("Add") {
                let wizard = Wizard(context: self.moc)
                wizard.name = "Harry Potter"
            }

            Button("Save") {
                do {
                    try self.moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct UniqueConstraints_Previews: PreviewProvider {
    static var previews: some View {
        UniqueConstraints()
    }
}
