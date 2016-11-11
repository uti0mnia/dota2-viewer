//
//  Hero+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2016-11-10.
//
//

import Foundation
import CoreData


extension Hero {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hero> {
        return NSFetchRequest<Hero>(entityName: "Hero");
    }

    @NSManaged public var attackType: String!
    @NSManaged public var bio: String!
    @NSManaged public var primary_attribute: String!
    @NSManaged public var role: String!
    @NSManaged public var ability: NSOrderedSet!
    @NSManaged public var attributes: NSSet!
    @NSManaged public var stats: Stats!

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

// MARK: Generated accessors for attributes
extension Hero {

    @objc(addAttributesObject:)
    @NSManaged public func addToAttributes(_ value: Attribute)

    @objc(removeAttributesObject:)
    @NSManaged public func removeFromAttributes(_ value: Attribute)

    @objc(addAttributes:)
    @NSManaged public func addToAttributes(_ values: NSSet)

    @objc(removeAttributes:)
    @NSManaged public func removeFromAttributes(_ values: NSSet)

}
