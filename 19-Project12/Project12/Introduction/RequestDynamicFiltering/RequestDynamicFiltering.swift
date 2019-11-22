//
//  RequestDynamicFiltering.swift
//  Project12
//
//  Created by clarknt on 2019-11-22.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct FilteredList: View {
    var fetchRequest: FetchRequest<Singer>
    var singers: FetchedResults<Singer> {
        fetchRequest.wrappedValue
    }

    init(filter: String) {
        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
    }

    var body: some View {
        List(singers, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
}

struct RequestDynamicFiltering: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"

    var body: some View {
        VStack {
            // list of matching singers
            FilteredList(filter: lastNameFilter)

            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? self.moc.save()
            }

            Button("Show A") {
                self.lastNameFilter = "A"
            }

            Button("Show S") {
                self.lastNameFilter = "S"
            }
        }
    }
}

struct RequestDynamicFiltering_Previews: PreviewProvider {
    static var previews: some View {
        RequestDynamicFiltering()
    }
}
