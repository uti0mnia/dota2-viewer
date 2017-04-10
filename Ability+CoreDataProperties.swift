//
//  Ability+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData


extension Ability {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ability> {
        return NSFetchRequest<Ability>(entityName: "Ability")
    }

    @NSManaged public var descrip: String?
    @NSManaged public var name: String?
    @NSManaged public var specialDetails: NSObject?
    @NSManaged public var specials: NSObject?
    @NSManaged public var cooldown: ModifiableValue?
    @NSManaged public var data: NSOrderedSet?
    @NSManaged public var mana: ModifiableValue?
    @NSManaged public var modifiers: NSSet?
    @NSManaged public var notes: NSOrderedSet?
    @NSManaged public var object: Object?
    @NSManaged public var types: NSOrderedSet?

}

// MARK: Generated accessors for data
extension Ability {

    @objc(insertObject:inDataAtIndex:)
    @NSManaged public func insertIntoData(_ value: ModifiableValue, at idx: Int)

    @objc(removeObjectFromDataAtIndex:)
    @NSManaged public func removeFromData(at idx: Int)

    @objc(insertData:atIndexes:)
    @NSManaged public func insertIntoData(_ values: [ModifiableValue], at indexes: NSIndexSet)

    @objc(removeDataAtIndexes:)
    @NSManaged public func removeFromData(at indexes: NSIndexSet)

    @objc(replaceObjectInDataAtIndex:withObject:)
    @NSManaged public func replaceData(at idx: Int, with value: ModifiableValue)

    @objc(replaceDataAtIndexes:withData:)
    @NSManaged public func replaceData(at indexes: NSIndexSet, with values: [ModifiableValue])

    @objc(addDataObject:)
    @NSManaged public func addToData(_ value: ModifiableValue)

    @objc(removeDataObject:)
    @NSManaged public func removeFromData(_ value: ModifiableValue)

    @objc(addData:)
    @NSManaged public func addToData(_ values: NSOrderedSet)

    @objc(removeData:)
    @NSManaged public func removeFromData(_ values: NSOrderedSet)

}

// MARK: Generated accessors for modifiers
extension Ability {

    @objc(addModifiersObject:)
    @NSManaged public func addToModifiers(_ value: Modifer)

    @objc(removeModifiersObject:)
    @NSManaged public func removeFromModifiers(_ value: Modifer)

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

    @objc(insertObject:inTypesAtIndex:)
    @NSManaged public func insertIntoTypes(_ value: ModifiableValue, at idx: Int)

    @objc(removeObjectFromTypesAtIndex:)
    @NSManaged public func removeFromTypes(at idx: Int)

    @objc(insertTypes:atIndexes:)
    @NSManaged public func insertIntoTypes(_ values: [ModifiableValue], at indexes: NSIndexSet)

    @objc(removeTypesAtIndexes:)
    @NSManaged public func removeFromTypes(at indexes: NSIndexSet)

    @objc(replaceObjectInTypesAtIndex:withObject:)
    @NSManaged public func replaceTypes(at idx: Int, with value: ModifiableValue)

    @objc(replaceTypesAtIndexes:withTypes:)
    @NSManaged public func replaceTypes(at indexes: NSIndexSet, with values: [ModifiableValue])

    @objc(addTypesObject:)
    @NSManaged public func addToTypes(_ value: ModifiableValue)

    @objc(removeTypesObject:)
    @NSManaged public func removeFromTypes(_ value: ModifiableValue)

    @objc(addTypes:)
    @NSManaged public func addToTypes(_ values: NSOrderedSet)

    @objc(removeTypes:)
    @NSManaged public func removeFromTypes(_ values: NSOrderedSet)

}
