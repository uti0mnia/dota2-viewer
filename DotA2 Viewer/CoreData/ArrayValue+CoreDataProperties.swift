//
//  ArrayValue+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2016-12-19.
//
//

import Foundation
import CoreData


extension ArrayValue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArrayValue> {
        return NSFetchRequest<ArrayValue>(entityName: "ArrayValue");
    }

    @NSManaged public var value: String?
    @NSManaged public var abilityData: Ability?
    @NSManaged public var abilityModifiers: Ability?
    @NSManaged public var abilitySpecial: Ability?
    @NSManaged public var abilitySpecialDetails: Ability?
    @NSManaged public var abilityType: AbilityType?
    @NSManaged public var heroRole: Hero?
    @NSManaged public var itemAdditionalInfo: Item?
    @NSManaged public var itemAvailability: Item?
    @NSManaged public var itemBuildsFrom: Item?
    @NSManaged public var itemBuildsInto: Item?
    @NSManaged public var itemDetail: ItemDetail?
    @NSManaged public var heroTalentNotes: Hero?

}