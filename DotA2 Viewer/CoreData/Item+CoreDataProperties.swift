//
//  Item+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var cost: Double
    @NSManaged public var details: [String: [String]]
    @NSManaged public var recipeCost: Double
    @NSManaged public var type: String
    @NSManaged public var additionalInfo: NSOrderedSet?
    @NSManaged public var availability: NSSet?
    @NSManaged public var buildsFrom: NSSet?
    @NSManaged public var buildsInto: NSSet?

}

// MARK: Generated accessors for additionalInfo
extension Item {

    @objc(insertObject:inAdditionalInfoAtIndex:)
    @NSManaged public func insertIntoAdditionalInfo(_ value: ArrayItem, at idx: Int)

    @objc(removeObjectFromAdditionalInfoAtIndex:)
    @NSManaged public func removeFromAdditionalInfo(at idx: Int)

    @objc(insertAdditionalInfo:atIndexes:)
    @NSManaged public func insertIntoAdditionalInfo(_ values: [ArrayItem], at indexes: NSIndexSet)

    @objc(removeAdditionalInfoAtIndexes:)
    @NSManaged public func removeFromAdditionalInfo(at indexes: NSIndexSet)

    @objc(replaceObjectInAdditionalInfoAtIndex:withObject:)
    @NSManaged public func replaceAdditionalInfo(at idx: Int, with value: ArrayItem)

    @objc(replaceAdditionalInfoAtIndexes:withAdditionalInfo:)
    @NSManaged public func replaceAdditionalInfo(at indexes: NSIndexSet, with values: [ArrayItem])

    @objc(addAdditionalInfoObject:)
    @NSManaged public func addToAdditionalInfo(_ value: ArrayItem)

    @objc(removeAdditionalInfoObject:)
    @NSManaged public func removeFromAdditionalInfo(_ value: ArrayItem)

    @objc(addAdditionalInfo:)
    @NSManaged public func addToAdditionalInfo(_ values: NSOrderedSet)

    @objc(removeAdditionalInfo:)
    @NSManaged public func removeFromAdditionalInfo(_ values: NSOrderedSet)

}

// MARK: Generated accessors for availability
extension Item {

    @objc(addAvailabilityObject:)
    @NSManaged public func addToAvailability(_ value: ArrayItem)

    @objc(removeAvailabilityObject:)
    @NSManaged public func removeFromAvailability(_ value: ArrayItem)

    @objc(addAvailability:)
    @NSManaged public func addToAvailability(_ values: NSSet)

    @objc(removeAvailability:)
    @NSManaged public func removeFromAvailability(_ values: NSSet)

}

// MARK: Generated accessors for buildsInto
extension Item {

    @objc(addBuildsIntoObject:)
    @NSManaged public func addToBuildsInto(_ value: ArrayItem)

    @objc(removeBuildsIntoObject:)
    @NSManaged public func removeFromBuildsInto(_ value: ArrayItem)

    @objc(addBuildsInto:)
    @NSManaged public func addToBuildsInto(_ values: NSSet)

    @objc(removeBuildsInto:)
    @NSManaged public func removeFromBuildsInto(_ values: NSSet)

}
