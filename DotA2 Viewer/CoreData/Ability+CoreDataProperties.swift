//
//  Ability+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2016-12-13.
//
//

import Foundation
import CoreData


extension Ability {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ability> {
        return NSFetchRequest<Ability>(entityName: "Ability");
    }

    @NSManaged public var cooldown: String?
    @NSManaged public var mana: String?
    @NSManaged public var name: String?
    @NSManaged public var summary: String?
    @NSManaged public var abilitySpecial: NSSet?
    @NSManaged public var data: NSSet?
    @NSManaged public var hero: Hero?
    @NSManaged public var item: Item?
    @NSManaged public var modifiers: NSSet?
    @NSManaged public var notes: NSOrderedSet?
    @NSManaged public var type: NSSet?
    @NSManaged public var specialDetails: NSSet?

}

// MARK: Generated accessors for abilitySpecial
extension Ability {

    @objc(addAbilitySpecialObject:)
    @NSManaged public func addToAbilitySpecial(_ value: ArrayValue)

    @objc(removeAbilitySpecialObject:)
    @NSManaged public func removeFromAbilitySpecial(_ value: ArrayValue)

    @objc(addAbilitySpecial:)
    @NSManaged public func addToAbilitySpecial(_ values: NSSet)

    @objc(removeAbilitySpecial:)
    @NSManaged public func removeFromAbilitySpecial(_ values: NSSet)

}

// MARK: Generated accessors for data
extension Ability {

    @objc(addDataObject:)
    @NSManaged public func addToData(_ value: ArrayValue)

    @objc(removeDataObject:)
    @NSManaged public func removeFromData(_ value: ArrayValue)

    @objc(addData:)
    @NSManaged public func addToData(_ values: NSSet)

    @objc(removeData:)
    @NSManaged public func removeFromData(_ values: NSSet)

}

// MARK: Generated accessors for modifiers
extension Ability {

    @objc(addModifiersObject:)
    @NSManaged public func addToModifiers(_ value: ArrayValue)

    @objc(removeModifiersObject:)
    @NSManaged public func removeFromModifiers(_ value: ArrayValue)

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

// MARK: Generated accessors for type
extension Ability {

    @objc(addTypeObject:)
    @NSManaged public func addToType(_ value: AbilityType)

    @objc(removeTypeObject:)
    @NSManaged public func removeFromType(_ value: AbilityType)

    @objc(addType:)
    @NSManaged public func addToType(_ values: NSSet)

    @objc(removeType:)
    @NSManaged public func removeFromType(_ values: NSSet)

}

// MARK: Generated accessors for specialDetails
extension Ability {

    @objc(addSpecialDetailsObject:)
    @NSManaged public func addToSpecialDetails(_ value: ArrayValue)

    @objc(removeSpecialDetailsObject:)
    @NSManaged public func removeFromSpecialDetails(_ value: ArrayValue)

    @objc(addSpecialDetails:)
    @NSManaged public func addToSpecialDetails(_ values: NSSet)

    @objc(removeSpecialDetails:)
    @NSManaged public func removeFromSpecialDetails(_ values: NSSet)

}
