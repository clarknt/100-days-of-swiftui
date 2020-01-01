//
//  RequestDynamicFilteringGeneric.swift
//  Project12
//
//  Created by clarknt on 2019-11-22.
//  Copyright © 2019 clarknt. All rights reserved.
//

import CoreData
import SwiftUI

struct GenericFilteredList<Entity: NSManagedObject, ContentView: View>: View{
    var fetchRequest: FetchRequest<Entity>
    var entities: FetchedResults<Entity> {
        fetchRequest.wrappedValue
    }
    var view: (Entity) -> ContentView

    // @ViewBuilder lets the caller send multiple views
    init(filter: String, keyName: String, @ViewBuilder view: @escaping (Entity) -> ContentView) {
        self.view = view
        // note: "%@" will insert single quotes, "%K" won't
        fetchRequest = FetchRequest<Entity>(entity: Entity.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", keyName, filter))
    }

    var body: some View {
        List(entities, id: \.self) { entity in
            self.view(entity)
        }
    }
}

struct GenericRequestDynamicFiltering: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"

    var body: some View {
        VStack {
            // list of matching singers
            GenericFilteredList(filter: lastNameFilter, keyName: "lastName") { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }

            // other possible syntax
//            GenericFilteredList<Singer, Text>(filter: lastNameFilter, keyName: "lastName") { singer in
//                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
//            }

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

struct GenericRequestDynamicFiltering_Previews: PreviewProvider {
    static var previews: some View {
        RequestDynamicFiltering()
    }
}
