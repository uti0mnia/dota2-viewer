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

    @NSManaged public var armor: Double
    @NSManaged public var attackPerSecond: Double
    @NSManaged public var hp: Double
    @NSManaged public var hpRegen: Double
    @NSManaged public var mana: Double
    @NSManaged public var manaRegen: Double
    @NSManaged public var maxDamage: Double
    @NSManaged public var minDamage: Double
    @NSManaged public var spellDamage: Double
    @NSManaged public var hero: Hero

}
