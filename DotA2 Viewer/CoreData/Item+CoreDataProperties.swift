//
//  Item+CoreDataProperties.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-02-13.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var additionalInfo: NSObject?
    @NSManaged public var availability: NSObject?
    @NSManaged public var details: NSObject?
    @NSManaged public var lore: String?
    @NSManaged public var type: String?
    @NSManaged public var abilities: NSOrderedSet?
    @NSManaged public var cost: Tuple?

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
