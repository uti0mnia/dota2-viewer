//
//  Hero+CoreDataProperties.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-15.
//  Copyright © 2016 self. All rights reserved.
//

import Foundation
import CoreData


extension Hero {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hero> {
        return NSFetchRequest<Hero>(entityName: "Hero");
    }

    @NSManaged public var attackType: String?
    @NSManaged public var attribute: String?
    @NSManaged public var bio: String?
    @NSManaged public var role: String?
    @NSManaged public var ability: NSSet?
    @NSManaged public var primaryStat: PrimaryStat?
    @NSManaged public var stat: NSSet?

}

// MARK: Generated accessors for ability
extension Hero {

    @objc(addAbilityObject:)
    @NSManaged public func addToAbility(_ value: Ability)

    @objc(removeAbilityObject:)
    @NSManaged public func removeFromAbility(_ value: Ability)

    @objc(addAbility:)
    @NSManaged public func addToAbility(_ values: NSSet)

    @objc(removeAbility:)
    @NSManaged public func removeFromAbility(_ values: NSSet)

}

// MARK: Generated accessors for stat
extension Hero {

    @objc(addStatObject:)
    @NSManaged public func addToStat(_ value: Stat)

    @objc(removeStatObject:)
    @NSManaged public func removeFromStat(_ value: Stat)

    @objc(addStat:)
    @NSManaged public func addToStat(_ values: NSSet)

    @objc(removeStat:)
    @NSManaged public func removeFromStat(_ values: NSSet)

}
