//
//  AbilityType+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2016-12-03.
//
//

import Foundation
import CoreData


extension AbilityType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AbilityType> {
        return NSFetchRequest<AbilityType>(entityName: "AbilityType");
    }

    @NSManaged public var type: String?
    @NSManaged public var value: NSSet?
    @NSManaged public var ability: Ability?

}

// MARK: Generated accessors for value
extension AbilityType {

    @objc(addValueObject:)
    @NSManaged public func addToValue(_ value: ArrayValue)

    @objc(removeValueObject:)
    @NSManaged public func removeFromValue(_ value: ArrayValue)

    @objc(addValue:)
    @NSManaged public func addToValue(_ values: NSSet)

    @objc(removeValue:)
    @NSManaged public func removeFromValue(_ values: NSSet)

}
