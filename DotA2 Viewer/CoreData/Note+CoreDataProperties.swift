//
//  Note+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var value: [String]
    @NSManaged public var ability: Ability?
    @NSManaged public var hero: Note?
    @NSManaged public var heroTalentNotes: Hero?
    @NSManaged public var subnotes: NSOrderedSet?

}

// MARK: Generated accessors for subnotes
extension Note {

    @objc(addSubnotesObject:)
    @NSManaged public func addToSubnotes(_ value: Note)

    @objc(removeSubnotesObject:)
    @NSManaged public func removeFromSubnotes(_ value: Note)

    @objc(addSubnotes:)
    @NSManaged public func addToSubnotes(_ values: NSSet)

    @objc(removeSubnotes:)
    @NSManaged public func removeFromSubnotes(_ values: NSSet)

}
