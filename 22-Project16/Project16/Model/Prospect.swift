//
//  Prospect.swift
//  Project16
//
//  Created by clarknt on 2019-12-30.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false

    // Challenge 3
    var date = Date()
}

class Prospects: ObservableObject {
    static let saveKey = "SavedData"

    @Published private(set) var people: [Prospect]

    init() {
        // Challenge 2
        self.people = []

        // User defaults
        //if let data = UserDefaults.standard.data(forKey: Self.saveKey) {

        // File
        if let data = loadFile() {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            }
        }
    }

    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }

    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            // Challenge 2

            // User defaults
            //UserDefaults.standard.set(encoded, forKey: Self.saveKey)

            // File
            saveFile(data: encoded)
        }
    }

    // Challenge 2
    private func saveFile(data: Data) {
        let url = getDocumentDirectory().appendingPathComponent(Self.saveKey)

        do {
            try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
        }
        catch let error {
            print("Could not write data: " + error.localizedDescription)
        }
    }

    // Challenge 2
    private func loadFile() -> Data? {
        let url = getDocumentDirectory().appendingPathComponent(Self.saveKey)
        if let data = try? Data(contentsOf: url) {
            return data
        }

        return nil
    }

    // Challenge 2
    private func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
