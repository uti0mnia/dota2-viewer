//
//  Item+CoreDataProperties.swift
//  
//
//  Created by McLewin, Casey on 2016-12-09.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var cost: String?
    @NSManaged public var lore: String?
    @NSManaged public var type: String?
    @NSManaged public var abilities: NSOrderedSet?
    @NSManaged public var additionalInfo: NSSet?
    @NSManaged public var details: NSSet?
    @NSManaged public var availability: NSSet?
    @NSManaged public var buildsFrom: NSSet?
    @NSManaged public var buildsInto: NSSet?

}

// MARK: Generated accessors for abilities
extension Item {

    @objc(insertObject:inAbilitiesAtIndex:)
    @NSManaged public func insertIntoAbilities(_ value: Ability, at idx: Int)

    @objc(removeObjectFromAbilitiesAtIndex:)
    @NSManaged public func removeFromAbilities(at idx: Int)

    @objc(insertAbilities:atIndexes:)
    @NSManaged public func insertIntoAbilities(_ values: [Ability], at indexes: NSIndexSet)

    @objc(removeAbilitiesAtIndexes:)
    @NSManaged public func removeFromAbilities(at indexes: NSIndexSet)

    @objc(replaceObjectInAbilitiesAtIndex:withObject:)
    @NSManaged public func replaceAbilities(at idx: Int, with value: Ability)

    @objc(replaceAbilitiesAtIndexes:withAbilities:)
    @NSManaged public func replaceAbilities(at indexes: NSIndexSet, with values: [Ability])

    @objc(addAbilitiesObject:)
    @NSManaged public func addToAbilities(_ value: Ability)

    @objc(removeAbilitiesObject:)
    @NSManaged public func removeFromAbilities(_ value: Ability)

    @objc(addAbilities:)
    @NSManaged public func addToAbilities(_ values: NSOrderedSet)

    @objc(removeAbilities:)
    @NSManaged public func removeFromAbilities(_ values: NSOrderedSet)

}

// MARK: Generated accessors for additionalInfo
extension Item {

    @objc(addAdditionalInfoObject:)
    @NSManaged public func addToAdditionalInfo(_ value: ArrayValue)

    @objc(removeAdditionalInfoObject:)
    @NSManaged public func removeFromAdditionalInfo(_ value: ArrayValue)

    @objc(addAdditionalInfo:)
    @NSManaged public func addToAdditionalInfo(_ values: NSSet)

    @objc(removeAdditionalInfo:)
    @NSManaged public func removeFromAdditionalInfo(_ values: NSSet)

}

// MARK: Generated accessors for details
extension Item {

    @objc(addDetailsObject:)
    @NSManaged public func addToDetails(_ value: ItemDetail)

    @objc(removeDetailsObject:)
    @NSManaged public func removeFromDetails(_ value: ItemDetail)

    @objc(addDetails:)
    @NSManaged public func addToDetails(_ values: NSSet)

    @objc(removeDetails:)
    @NSManaged public func removeFromDetails(_ values: NSSet)

}

// MARK: Generated accessors for availability
extension Item {

    @objc(addAvailabilityObject:)
    @NSManaged public func addToAvailability(_ value: ArrayValue)

    @objc(removeAvailabilityObject:)
    @NSManaged public func removeFromAvailability(_ value: ArrayValue)

    @objc(addAvailability:)
    @NSManaged public func addToAvailability(_ values: NSSet)

    @objc(removeAvailability:)
    @NSManaged public func removeFromAvailability(_ values: NSSet)

}

// MARK: Generated accessors for buildsFrom
extension Item {

    @objc(addBuildsFromObject:)
    @NSManaged public func addToBuildsFrom(_ value: ArrayValue)

    @objc(removeBuildsFromObject:)
    @NSManaged public func removeFromBuildsFrom(_ value: ArrayValue)

    @objc(addBuildsFrom:)
    @NSManaged public func addToBuildsFrom(_ values: NSSet)

    @objc(removeBuildsFrom:)
    @NSManaged public func removeFromBuildsFrom(_ values: NSSet)

}

// MARK: Generated accessors for buildsInto
extension Item {

    @objc(addBuildsIntoObject:)
    @NSManaged public func addToBuildsInto(_ value: ArrayValue)

    @objc(removeBuildsIntoObject:)
    @NSManaged public func removeFromBuildsInto(_ value: ArrayValue)

    @objc(addBuildsInto:)
    @NSManaged public func addToBuildsInto(_ values: NSSet)

    @objc(removeBuildsInto:)
    @NSManaged public func removeFromBuildsInto(_ values: NSSet)

}
