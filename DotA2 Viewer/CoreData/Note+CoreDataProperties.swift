//
//  Note+CoreDataProperties.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-02-13.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note");
    }

    @NSManaged public var string: String?
    @NSManaged public var ability: Ability?
    @NSManaged public var note: Note?
    @NSManaged public var subNotes: NSOrderedSet?
    @NSManaged public var heroTalent: Talent?

}

// MARK: Generated accessors for subNotes
extension Note {

    @objc(insertObject:inSubNotesAtIndex:)
    @NSManaged public func insertIntoSubNotes(_ value: Note, at idx: Int)

    @objc(removeObjectFromSubNotesAtIndex:)
    @NSManaged public func removeFromSubNotes(at idx: Int)

    @objc(insertSubNotes:atIndexes:)
    @NSManaged public func insertIntoSubNotes(_ values: [Note], at indexes: NSIndexSet)

    @objc(removeSubNotesAtIndexes:)
    @NSManaged public func removeFromSubNotes(at indexes: NSIndexSet)

    @objc(replaceObjectInSubNotesAtIndex:withObject:)
    @NSManaged public func replaceSubNotes(at idx: Int, with value: Note)

    @objc(replaceSubNotesAtIndexes:withSubNotes:)
    @NSManaged public func replaceSubNotes(at indexes: NSIndexSet, with values: [Note])

    @objc(addSubNotesObject:)
    @NSManaged public func addToSubNotes(_ value: Note)

    @objc(removeSubNotesObject:)
    @NSManaged public func removeFromSubNotes(_ value: Note)

    @objc(addSubNotes:)
    @NSManaged public func addToSubNotes(_ values: NSOrderedSet)

    @objc(removeSubNotes:)
    @NSManaged public func removeFromSubNotes(_ values: NSOrderedSet)

}
