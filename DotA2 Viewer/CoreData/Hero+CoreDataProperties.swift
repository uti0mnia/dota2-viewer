//
//  Hero+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2016-11-30.
//
//

import Foundation
import CoreData


extension Hero {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hero> {
        return NSFetchRequest<Hero>(entityName: "Hero");
    }

    @NSManaged public var lore: String?
    @NSManaged public var summary: String?
    @NSManaged public var abilities: NSOrderedSet?
    @NSManaged public var attribute: NSSet?
    @NSManaged public var baseStats: BaseStat?
    @NSManaged public var miscStats: MiscStat?
    @NSManaged public var roles: NSSet?

}

// MARK: Generated accessors for ability
extension Hero {

    @objc(insertObject:inAbilityAtIndex:)
    @NSManaged public func insertIntoAbility(_ value: Ability, at idx: Int)

    @objc(removeObjectFromAbilityAtIndex:)
    @NSManaged public func removeFromAbility(at idx: Int)

    @objc(insertAbility:atIndexes:)
    @NSManaged public func insertIntoAbility(_ values: [Ability], at indexes: NSIndexSet)

    @objc(removeAbilityAtIndexes:)
    @NSManaged public func removeFromAbility(at indexes: NSIndexSet)

    @objc(replaceObjectInAbilityAtIndex:withObject:)
    @NSManaged public func replaceAbility(at idx: Int, with value: Ability)

    @objc(replaceAbilityAtIndexes:withAbility:)
    @NSManaged public func replaceAbility(at indexes: NSIndexSet, with values: [Ability])

    @objc(addAbilityObject:)
    @NSManaged public func addToAbility(_ value: Ability)

    @objc(removeAbilityObject:)
    @NSManaged public func removeFromAbility(_ value: Ability)

    @objc(addAbility:)
    @NSManaged public func addToAbility(_ values: NSOrderedSet)

    @objc(removeAbility:)
    @NSManaged public func removeFromAbility(_ values: NSOrderedSet)

}

// MARK: Generated accessors for attribute
extension Hero {

    @objc(addAttributeObject:)
    @NSManaged public func addToAttribute(_ value: Attribute)

    @objc(removeAttributeObject:)
    @NSManaged public func removeFromAttribute(_ value: Attribute)

    @objc(addAttribute:)
    @NSManaged public func addToAttribute(_ values: NSSet)

    @objc(removeAttribute:)
    @NSManaged public func removeFromAttribute(_ values: NSSet)

}

// MARK: Generated accessors for roles
extension Hero {

    @objc(addRolesObject:)
    @NSManaged public func addToRoles(_ value: ArrayValue)

    @objc(removeRolesObject:)
    @NSManaged public func removeFromRoles(_ value: ArrayValue)

    @objc(addRoles:)
    @NSManaged public func addToRoles(_ values: NSSet)

    @objc(removeRoles:)
    @NSManaged public func removeFromRoles(_ values: NSSet)

}
