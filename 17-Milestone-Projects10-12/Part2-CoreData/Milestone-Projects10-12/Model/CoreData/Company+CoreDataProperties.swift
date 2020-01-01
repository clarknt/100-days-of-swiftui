//
//  Company+CoreDataProperties.swift
//  Milestone-Projects10-12
//
//  Created by clarknt on 2019-11-27.
//  Copyright © 2019 clarknt. All rights reserved.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var name: String?
    @NSManaged public var users: NSSet?

    public var uwName: String {
        name ?? "Unknown name"
    }

}

// MARK: Generated accessors for users
extension Company {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: User)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: User)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}
