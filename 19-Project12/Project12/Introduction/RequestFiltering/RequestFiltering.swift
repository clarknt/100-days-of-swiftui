//
//  RequestFiltering.swift
//  Project12
//
//  Created by clarknt on 2019-11-21.
//  Copyright © 2019 clarknt. All rights reserved.
//

import CoreData
import SwiftUI

struct RequestFiltering: View {
    @Environment(\.managedObjectContext) var moc

//    NSPredicate(format: "universe == 'Star Wars'")
//    NSPredicate(format: "universe == %@", "Star Wars") // avoid messing with quotes
//    NSPredicate(format: "name < %@", "F", "Star Wars") // will return Defiant, Enterprise, and Executor
//    NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"]) // universe is one of 3 options
//    NSPredicate(format: "name BEGINSWITH %@", "E") // all ships that start with a capital E
//    NSPredicate(format: "name BEGINSWITH[c] %@", "e") // ignore case
//    NSPredicate(format: "name CONTAINS[c] %@", "e") // contains + ignore case
//    NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e") // negation
//    NSPredicate(format: "NOT name BEGINSWITH[c] %@ AND name CONTAINS[c] %@", "e", "t") // multiple predicates
    static let startWithE = NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")
    static let doesNotContainT = NSPredicate(format: "name CONTAINS[c] %@", "t")
    static let compound = NSCompoundPredicate.init(andPredicateWithSubpredicates: [startWithE, doesNotContainT])
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: Self.compound) var ships: FetchedResults<Ship>

    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
//                    .onAppear(perform: { self.moc.delete(ship); try? self.moc.save() })
            }

            Button("Add Examples") {
                let ship1 = Ship(context: self.moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"

                let ship2 = Ship(context: self.moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context: self.moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context: self.moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"

                try? self.moc.save()
            }
        }
    }
}

struct RequestFiltering_Previews: PreviewProvider {
    static var previews: some View {
        RequestFiltering()
    }
}
