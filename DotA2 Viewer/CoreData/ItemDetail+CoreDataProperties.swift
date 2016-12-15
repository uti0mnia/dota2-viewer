//
//  ItemDetail+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2016-11-30.
//
//

import Foundation
import CoreData


extension ItemDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemDetail> {
        return NSFetchRequest<ItemDetail>(entityName: "ItemDetail");
    }

    @NSManaged public var name: String?
    @NSManaged public var item: Item?
    @NSManaged public var value: NSOrderedSet?

}

// MARK: Generated accessors for value
extension ItemDetail {

    @objc(insertObject:inValueAtIndex:)
    @NSManaged public func insertIntoValue(_ value: ArrayValue, at idx: Int)

    @objc(removeObjectFromValueAtIndex:)
    @NSManaged public func removeFromValue(at idx: Int)

    @objc(insertValue:atIndexes:)
    @NSManaged public func insertIntoValue(_ values: [ArrayValue], at indexes: NSIndexSet)

    @objc(removeValueAtIndexes:)
    @NSManaged public func removeFromValue(at indexes: NSIndexSet)

    @objc(replaceObjectInValueAtIndex:withObject:)
    @NSManaged public func replaceValue(at idx: Int, with value: ArrayValue)

    @objc(replaceValueAtIndexes:withValue:)
    @NSManaged public func replaceValue(at indexes: NSIndexSet, with values: [ArrayValue])

    @objc(addValueObject:)
    @NSManaged public func addToValue(_ value: ArrayValue)

    @objc(removeValueObject:)
    @NSManaged public func removeFromValue(_ value: ArrayValue)

    @objc(addValue:)
    @NSManaged public func addToValue(_ values: NSOrderedSet)

    @objc(removeValue:)
    @NSManaged public func removeFromValue(_ values: NSOrderedSet)

}
