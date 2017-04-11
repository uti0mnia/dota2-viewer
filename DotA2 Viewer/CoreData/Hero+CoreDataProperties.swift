//
//  Hero+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData


extension Hero {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hero> {
        return NSFetchRequest<Hero>(entityName: "Hero")
    }

    @NSManaged public var descript: String
    @NSManaged public var attributes: NSOrderedSet
    @NSManaged public var base: BaseStats
    @NSManaged public var maxDamage: Double
    @NSManaged public var minDamage: Double
    @NSManaged public var misc: MiscStats
    @NSManaged public var roles: NSSet
    @NSManaged public var talentNotes: NSOrderedSet?
    @NSManaged public var talents: NSSet

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

// MARK: Generated accessors for roles
extension Hero {

    @objc(addRolesObject:)
    @NSManaged public func addToRoles(_ value: ArrayItem)

    @objc(removeRolesObject:)
    @NSManaged public func removeFromRoles(_ value: ArrayItem)

    @objc(addRoles:)
    @NSManaged public func addToRoles(_ values: NSSet)

    @objc(removeRoles:)
    @NSManaged public func removeFromRoles(_ values: NSSet)

}

// MARK: Generated accessors for talentNotes
extension Hero {

    @objc(insertObject:inTalentNotesAtIndex:)
    @NSManaged public func insertIntoTalentNotes(_ value: Note, at idx: Int)

    @objc(removeObjectFromTalentNotesAtIndex:)
    @NSManaged public func removeFromTalentNotes(at idx: Int)

    @objc(insertTalentNotes:atIndexes:)
    @NSManaged public func insertIntoTalentNotes(_ values: [Note], at indexes: NSIndexSet)

    @objc(removeTalentNotesAtIndexes:)
    @NSManaged public func removeFromTalentNotes(at indexes: NSIndexSet)

    @objc(replaceObjectInTalentNotesAtIndex:withObject:)
    @NSManaged public func replaceTalentNotes(at idx: Int, with value: Note)

    @objc(replaceTalentNotesAtIndexes:withTalentNotes:)
    @NSManaged public func replaceTalentNotes(at indexes: NSIndexSet, with values: [Note])

    @objc(addTalentNotesObject:)
    @NSManaged public func addToTalentNotes(_ value: Note)

    @objc(removeTalentNotesObject:)
    @NSManaged public func removeFromTalentNotes(_ value: Note)

    @objc(addTalentNotes:)
    @NSManaged public func addToTalentNotes(_ values: NSOrderedSet)

    @objc(removeTalentNotes:)
    @NSManaged public func removeFromTalentNotes(_ values: NSOrderedSet)

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
