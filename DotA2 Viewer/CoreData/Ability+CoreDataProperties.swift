//
//  Ability+CoreDataProperties.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-02-13.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import CoreData


extension Ability {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ability> {
        return NSFetchRequest<Ability>(entityName: "Ability");
    }

    @NSManaged public var name: String?
    @NSManaged public var specials: NSObject?
    @NSManaged public var summary: String?
    @NSManaged public var cooldown: DataItem?
    @NSManaged public var data: AbilityTuple?
    @NSManaged public var hero: Hero?
    @NSManaged public var item: Item?
    @NSManaged public var mana: DataItem?
    @NSManaged public var modifiers: NSSet?
    @NSManaged public var notes: NSOrderedSet?
    @NSManaged public var types: NSSet?

}

// MARK: Generated accessors for modifiers
extension Ability {

    @objc(addModifiersObject:)
    @NSManaged public func addToModifiers(_ value: AbilityModifier)

    @objc(removeModifiersObject:)
    @NSManaged public func removeFromModifiers(_ value: AbilityModifier)

    @objc(addModifiers:)
    @NSManaged public func addToModifiers(_ values: NSSet)

    @objc(removeModifiers:)
    @NSManaged public func removeFromModifiers(_ values: NSSet)

}

// MARK: Generated accessors for notes
extension Ability {

    @objc(insertObject:inNotesAtIndex:)
    @NSManaged public func insertIntoNotes(_ value: Note, at idx: Int)

    @objc(removeObjectFromNotesAtIndex:)
    @NSManaged public func removeFromNotes(at idx: Int)

    @objc(insertNotes:atIndexes:)
    @NSManaged public func insertIntoNotes(_ values: [Note], at indexes: NSIndexSet)

    @objc(removeNotesAtIndexes:)
    @NSManaged public func removeFromNotes(at indexes: NSIndexSet)

    @objc(replaceObjectInNotesAtIndex:withObject:)
    @NSManaged public func replaceNotes(at idx: Int, with value: Note)

    @objc(replaceNotesAtIndexes:withNotes:)
    @NSManaged public func replaceNotes(at indexes: NSIndexSet, with values: [Note])

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: Note)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: Note)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSOrderedSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSOrderedSet)

}

// MARK: Generated accessors for types
extension Ability {

    @objc(addTypesObject:)
    @NSManaged public func addToTypes(_ value: AbilityTuple)

    @objc(removeTypesObject:)
    @NSManaged public func removeFromTypes(_ value: AbilityTuple)

    @objc(addTypes:)
    @NSManaged public func addToTypes(_ values: NSSet)

    @objc(removeTypes:)
    @NSManaged public func removeFromTypes(_ values: NSSet)

}
