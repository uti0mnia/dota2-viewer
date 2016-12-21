//
//  Note+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2016-12-08.
//
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

}

// MARK: Generated accessors for subNotes
extension Note {

    @objc(addSubNotesObject:)
    @NSManaged public func addToSubNotes(_ value: Note)

    @objc(removeSubNotesObject:)
    @NSManaged public func removeFromSubNotes(_ value: Note)

    @objc(addSubNotes:)
    @NSManaged public func addToSubNotes(_ values: NSSet)

    @objc(removeSubNotes:)
    @NSManaged public func removeFromSubNotes(_ values: NSSet)

}
