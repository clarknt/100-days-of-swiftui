//
//  CoreDataPersons.swift
//  Milestone-Projects13-15
//
//  Created by clarknt on 2019-12-27.
//  Copyright © 2019 clarknt. All rights reserved.
//

import CoreData
import Foundation

/// Class should be created only once
/// (typically, initialize in SceneDelegate and inject where needed)
class CoreDataPersons: ObservableObject {

    // maintain and keep in sync 2 arrays:
    // one with actual data from Core Data and one for publication
    private var items = [CoreDataPerson]() {
        didSet {
            saveContext()
        }
    }

    /// Use add, update and remove functions for modification.
    @Published private(set) var all = [Person]()

    private var container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }

        loadSavedData()
    }

    func add(person: Person) {
        let cdPerson = CoreDataPerson(context: container.viewContext)
        cdPerson.id = person.id
        cdPerson.name = person.name
        cdPerson.imagePath = person.imagePath

        if let index = items.firstIndex(where: { $0.name > person.name }) {
            items.insert(cdPerson, at: index)
            all.insert(person, at: index)
        }
        else {
            items.append(cdPerson)
            all.append(person)
        }
    }

    // for demo purpose (not used in this project)
    func update(person: Person) {
        if let index = items.firstIndex(where: { $0.id == person.id }) {
            items[index].name = person.name
            items[index].imagePath = person.imagePath
            all[index] = person
            sort() // will persist data
        }
        else {
            print("Person not found")
        }
    }

    func remove(persons: [Person]) {
        for (index, item) in items.enumerated() {
            for person in persons {
                if person.id == item.id {
                    all[index].deleteImage()
                    container.viewContext.delete(item)
                    items.remove(at: index)
                    all.remove(at: index)
                }
            }
        }
    }

    private func loadSavedData() {
        let request = CoreDataPerson.createFetchRequest()
        let sort = NSSortDescriptor(key: "internalName", ascending: true)
        request.sortDescriptors = [sort]

        do {
            items = try container.viewContext.fetch(request)

            // fill in "all" array
            for item in items {

                let id = item.id ?? UUID()
                // corupted data
                if item.id == nil {
                    item.id = id
                    saveContext()
                }

                let person = Person(id: id, name: item.name, imagePath: item.imagePath)
                all.append(person)
            }
        } catch {
            print("Fetch failed")
        }
    }

    private func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }

    private func sort() {
        items.sort(by: { $0.name < $1.name } )
        all.sort(by: { $0.name < $1.name } )
    }
}
