//
//  ConditionalSaving.swift
//  Project12
//
//  Created by clarknt on 2019-11-20.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct ConditionalSaving: View {
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        Button("Save") {
            // Apple specifically states that we should always check for
            // uncommitted changes before calling save(), to avoid making
            // Core Data do work that isn’t required
            if self.moc.hasChanges {
                try? self.moc.save()
            }
        }
    }
}

struct ConditionalSaving_Previews: PreviewProvider {
    static var previews: some View {
        ConditionalSaving()
    }
}
