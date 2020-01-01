//
//  User+CoreDataProperties.swift
//  Milestone-Projects10-12
//
//  Created by clarknt on 2019-11-27.
//  Copyright © 2019 clarknt. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var friend: NSSet?
    @NSManaged public var company: Company?

    public var uwName: String {
        name ?? "Unknown name"
    }

    public var uwEmail: String {
        email ?? "Unknown email"
    }

    public var uwAddress: String {
        address ?? "Unknown address"
    }

    public var uwCompanyName: String {
        company?.uwName ?? "Unkown company"
    }

    public var friendsArray: [User] {
        let set = friend as? Set<User> ?? []

        return set.sorted { $0.uwName < $1.uwName }
    }


}

// MARK: Generated accessors for friend
extension User {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: User)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: User)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}
