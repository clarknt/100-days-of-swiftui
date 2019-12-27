//
//  Persons.swift
//  Milestone-Projects13-15
//
//  Created by clarknt on 2019-12-17.
//  Copyright © 2019 clarknt. All rights reserved.
//

import Foundation

class Persons: ObservableObject {
    private static let personsKey = "persons"

    private var items = [Person]() {
        didSet {
            // save
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: Self.personsKey)
            }

            // copy to all
            all = items
        }
    }

    /// This is a read only array in the sense that modifying it will have no effect
    /// on persisted data. Use add and remove functions for actual modification.
    @Published var all = [Person]()

    init() {
        if let encoded = UserDefaults.standard.data(forKey: Self.personsKey) {
            if let decoded = try? JSONDecoder().decode([Person].self, from: encoded) {
                self.items = decoded
                self.all = items
            }
        }
    }

    func add(person: Person) {
        items.append(person)
        sort()
    }

    func remove(at offsets: IndexSet) {
        for offset in offsets {
            items[offset].deleteImage()
        }
        items.remove(atOffsets: offsets)
    }

    private func sort() {
        items.sort(by: { $0.name < $1.name } )
    }
}
