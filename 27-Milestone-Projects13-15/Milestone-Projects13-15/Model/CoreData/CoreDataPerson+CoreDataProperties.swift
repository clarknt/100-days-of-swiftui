//
//  CoreDataPerson+CoreDataProperties.swift
//  Milestone-Projects13-15
//
//  Created by clarknt on 2019-12-27.
//  Copyright © 2019 clarknt. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreDataPerson: Identifiable {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<CoreDataPerson> {
        return NSFetchRequest<CoreDataPerson>(entityName: "CoreDataPerson")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var imagePath: String?
    @NSManaged public var internalName: String?

    public var name: String {
        get {
            internalName ?? "Unknown name"
        }

        set {
            internalName = newValue
        }
    }
}
