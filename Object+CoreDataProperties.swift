//
//  Object+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData


extension Object {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Object> {
        return NSFetchRequest<Object>(entityName: "Object")
    }

    @NSManaged public var lore: String?
    @NSManaged public var name: String?
    @NSManaged public var abilities: NSOrderedSet?

}

// MARK: Generated accessors for abilities
extension Object {

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
