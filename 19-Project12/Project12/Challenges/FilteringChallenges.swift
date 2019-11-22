//
//  FilteringChallenges.swift
//  Project12
//
//  Created by clarknt on 2019-11-22.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

//
//  RequestDynamicFilteringGeneric.swift
//  Project12
//
//  Created by clarknt on 2019-11-22.
//  Copyright © 2019 clarknt. All rights reserved.
//

import CoreData
import SwiftUI

enum Predicates: String {
    case beginsWith = "BEGINSWITH"
    case contains = "CONTAINS"
    case beginsWithIgnoreCase = "BEGINSWITH[c]"
    case containsIgnoreCase = "CONTAINS[c]"
}

struct FilteredListChallenge<Entity: NSManagedObject, ContentView: View>: View{
    var fetchRequest: FetchRequest<Entity>
    var entities: FetchedResults<Entity> {
        fetchRequest.wrappedValue
    }
    var view: (Entity) -> ContentView

    // @ViewBuilder lets the caller send multiple views
    // challenges 1, 2 3
    init(predicate: Predicates = .beginsWith, filter: String, keyName: String, sortDescriptors: [NSSortDescriptor] = [], @ViewBuilder view: @escaping (Entity) -> ContentView) {
        self.view = view
        // note: "%@" will insert single quotes, "%K" won't
        // challenges 1, 2, 3
        fetchRequest = FetchRequest<Entity>(entity: Entity.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicate.rawValue) %@", keyName, filter))
    }

    var body: some View {
        List(entities, id: \.self) { entity in
            self.view(entity)
        }
    }
}

struct FilteringChallenge: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"

    // challenge 1
    private var sortBy = [NSSortDescriptor(key: "lastName", ascending: true)]

    var body: some View {
        VStack {
            // list of matching singers
            // challenges 1, 2, 3
            FilteredListChallenge(predicate: .beginsWith, filter: lastNameFilter, keyName: "lastName", sortDescriptors: sortBy) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
//                .onAppear(perform: { self.moc.delete(singer); try? self.moc.save() })
            }

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

struct FilteringChallenge_Previews: PreviewProvider {
    static var previews: some View {
        RequestDynamicFiltering()
    }
}
