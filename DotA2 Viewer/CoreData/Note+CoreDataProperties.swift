//
//  Note+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2016-11-30.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note");
    }

    @NSManaged public var note: String?
    @NSManaged public var ability: Ability?
    @NSManaged public var subnote: NSOrderedSet?

}

// MARK: Generated accessors for subnote
extension Note {

    @objc(insertObject:inSubnoteAtIndex:)
    @NSManaged public func insertIntoSubnote(_ value: Note, at idx: Int)

    @objc(removeObjectFromSubnoteAtIndex:)
    @NSManaged public func removeFromSubnote(at idx: Int)

    @objc(insertSubnote:atIndexes:)
    @NSManaged public func insertIntoSubnote(_ values: [Note], at indexes: NSIndexSet)

    @objc(removeSubnoteAtIndexes:)
    @NSManaged public func removeFromSubnote(at indexes: NSIndexSet)

    @objc(replaceObjectInSubnoteAtIndex:withObject:)
    @NSManaged public func replaceSubnote(at idx: Int, with value: Note)

    @objc(replaceSubnoteAtIndexes:withSubnote:)
    @NSManaged public func replaceSubnote(at indexes: NSIndexSet, with values: [Note])

    @objc(addSubnoteObject:)
    @NSManaged public func addToSubnote(_ value: Note)

    @objc(removeSubnoteObject:)
    @NSManaged public func removeFromSubnote(_ value: Note)

    @objc(addSubnote:)
    @NSManaged public func addToSubnote(_ values: NSOrderedSet)

    @objc(removeSubnote:)
    @NSManaged public func removeFromSubnote(_ values: NSOrderedSet)

}
