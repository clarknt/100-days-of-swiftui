//
//  Users.swift
//  Milestone-Projects10-12
//
//  Created by clarknt on 2019-11-26.
//  Copyright © 2019 clarknt. All rights reserved.
//

import CoreData
import Foundation

struct DataInitializer {

    static func loadData(moc: NSManagedObjectContext) {
        DispatchQueue.global().async {
            fetchData { users in
                // moc comes from the main thread
                DispatchQueue.main.async {
                    // store to add friends in 2 passes
                    var tmpUsers = [User]()

                    for user in users {
                        let newUser = User(context: moc)
                        newUser.id = user.id
                        newUser.name = user.name
                        newUser.age = Int16(user.age)
                        newUser.email = user.email
                        newUser.address = user.address

                        let company = Company(context: moc)
                        company.name = user.company
                        newUser.company = company

                        tmpUsers.append(newUser)
                    }

                    for i in 0..<users.count {
                        for friend in users[i].friends {
                            if let newFriend = tmpUsers.first(where: { $0.id == friend.id }) {
                                tmpUsers[i].addToFriend(newFriend)
                            }
                        }
                    }

                    do {
                        try moc.save()
                    }
                    catch let error {
                        print("Could not save data: \(error.localizedDescription)")
                    }
                }
            }
        }
    }

    static func fetchData(completion: @escaping ([JSONUser]) -> ()) {
        print("Fetching data...")
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)

        let session = URLSession.shared.dataTask(with: request) { data, response, sessionError in
            guard let data = data else {
                print("Fetch failed: \(sessionError?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let decoded = try JSONDecoder().decode([JSONUser].self, from: data)

                completion(decoded)
            }
            catch let decodingError {
                print("Decoding failed: \(decodingError.localizedDescription)")
            }
        }

        session.resume()
    }
}
