//
//  BaseStats+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData


extension BaseStats {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BaseStats> {
        return NSFetchRequest<BaseStats>(entityName: "BaseStats")
    }

    @NSManaged public var armor: Int16
    @NSManaged public var attackPerSecond: NSDecimalNumber?
    @NSManaged public var hp: Int16
    @NSManaged public var hpRegen: NSDecimalNumber?
    @NSManaged public var mana: Int16
    @NSManaged public var manaRegen: NSDecimalNumber?
    @NSManaged public var spellDamage: NSDecimalNumber?
    @NSManaged public var hero: Hero?

}
