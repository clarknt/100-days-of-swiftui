//
//  CoreDataRoll+CoreDataProperties.swift
//  Milestone-Projects16-18
//
//  Created by clarknt on 2020-01-26.
//  Copyright © 2020 clarknt. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreDataRoll {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<CoreDataRoll> {
        return NSFetchRequest<CoreDataRoll>(entityName: "CoreDataRoll")
    }

    @NSManaged public var dieSides: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var total: Int16
    @NSManaged public var date: Date?
    @NSManaged public var result: [Int16]?

}
