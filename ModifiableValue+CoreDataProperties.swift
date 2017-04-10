//
//  ModifiableValue+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData


extension ModifiableValue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ModifiableValue> {
        return NSFetchRequest<ModifiableValue>(entityName: "ModifiableValue")
    }

    @NSManaged public var aghs: String?
    @NSManaged public var aghsAndTalent: String?
    @NSManaged public var name: String?
    @NSManaged public var normal: String?
    @NSManaged public var talent: String?
    @NSManaged public var abilityCooldown: Ability?
    @NSManaged public var abilityData: Ability?
    @NSManaged public var abilityMana: Ability?
    @NSManaged public var abilityType: Ability?

}
