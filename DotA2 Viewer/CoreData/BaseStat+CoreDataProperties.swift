//
//  BaseStat+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2016-11-30.
//
//

import Foundation
import CoreData


extension BaseStat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BaseStat> {
        return NSFetchRequest<BaseStat>(entityName: "BaseStat");
    }

    @NSManaged public var armor: NSDecimalNumber?
    @NSManaged public var attackPerS: NSDecimalNumber?
    @NSManaged public var hp: NSDecimalNumber?
    @NSManaged public var hpRegen: NSDecimalNumber?
    @NSManaged public var mana: NSDecimalNumber?
    @NSManaged public var manaRegen: NSDecimalNumber?
    @NSManaged public var spellDamage: NSDecimalNumber?
    @NSManaged public var damage: Damage?
    @NSManaged public var hero: Hero?

}
