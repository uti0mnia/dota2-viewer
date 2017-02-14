//
//  Hero+CoreDataProperties.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-02-13.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import CoreData


extension Hero {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hero> {
        return NSFetchRequest<Hero>(entityName: "Hero");
    }

    @NSManaged public var lore: String?
    @NSManaged public var roles: NSObject?
    @NSManaged public var summary: String?
    @NSManaged public var abilities: NSOrderedSet?
    @NSManaged public var attributes: NSSet?
    @NSManaged public var baseStats: HeroBaseStat?
    @NSManaged public var miscStats: HeroMiscStat?
    @NSManaged public var talents: NSSet?

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

// MARK: Generated accessors for attributes
extension Hero {

    @objc(addAttributesObject:)
    @NSManaged public func addToAttributes(_ value: HeroAttribute)

    @objc(removeAttributesObject:)
    @NSManaged public func removeFromAttributes(_ value: HeroAttribute)

    @objc(addAttributes:)
    @NSManaged public func addToAttributes(_ values: NSSet)

    @objc(removeAttributes:)
    @NSManaged public func removeFromAttributes(_ values: NSSet)

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
