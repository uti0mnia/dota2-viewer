//
//  Hero+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2016-12-19.
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
    @NSManaged public var talents: NSSet?
    @NSManaged public var relationship: NSManagedObject?
    @NSManaged public var talentNotes: NSSet?

}

// MARK: Generated accessors for abilities
extension Hero {

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

// MARK: Generated accessors for talents
extension Hero {

    @objc(addTalentsObject:)
    @NSManaged public func addToTalents(_ value: Talent)

    @objc(removeTalentsObject:)
    @NSManaged public func removeFromTalents(_ value: Talent)

    @objc(addTalents:)
    @NSManaged public func addToTalents(_ values: NSSet)

    @objc(removeTalents:)
    @NSManaged public func removeFromTalents(_ values: NSSet)

}
