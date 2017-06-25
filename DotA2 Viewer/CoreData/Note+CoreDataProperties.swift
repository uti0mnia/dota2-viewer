//
//  Note+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2017-06-14.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var value: String
    @NSManaged public var ability: Ability?
    @NSManaged public var heroTalentNotes: Hero?
    @NSManaged public var itemAdditionalInfo: Item?
    @NSManaged public var subnotes: NSOrderedSet?
    @NSManaged public var parentNote: Note?

}

// MARK: Generated accessors for subnotes
extension Note {

    @objc(insertObject:inSubnotesAtIndex:)
    @NSManaged public func insertIntoSubnotes(_ value: Note, at idx: Int)

    @objc(removeObjectFromSubnotesAtIndex:)
    @NSManaged public func removeFromSubnotes(at idx: Int)

    @objc(insertSubnotes:atIndexes:)
    @NSManaged public func insertIntoSubnotes(_ values: [Note], at indexes: NSIndexSet)

    @objc(removeSubnotesAtIndexes:)
    @NSManaged public func removeFromSubnotes(at indexes: NSIndexSet)

    @objc(replaceObjectInSubnotesAtIndex:withObject:)
    @NSManaged public func replaceSubnotes(at idx: Int, with value: Note)

    @objc(replaceSubnotesAtIndexes:withSubnotes:)
    @NSManaged public func replaceSubnotes(at indexes: NSIndexSet, with values: [Note])

    @objc(addSubnotesObject:)
    @NSManaged public func addToSubnotes(_ value: Note)

    @objc(removeSubnotesObject:)
    @NSManaged public func removeFromSubnotes(_ value: Note)

    @objc(addSubnotes:)
    @NSManaged public func addToSubnotes(_ values: NSOrderedSet)

    @objc(removeSubnotes:)
    @NSManaged public func removeFromSubnotes(_ values: NSOrderedSet)

}
