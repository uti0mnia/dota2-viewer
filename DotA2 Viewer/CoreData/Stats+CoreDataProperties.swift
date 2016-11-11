//
//  Stats+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2016-11-10.
//
//

import Foundation
import CoreData


extension Stats {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stats> {
        return NSFetchRequest<Stats>(entityName: "Stats");
    }

    @NSManaged public var armor: NSDecimalNumber!
    @NSManaged public var attackAnimation: String!
    @NSManaged public var attackRange: NSDecimalNumber!
    @NSManaged public var damage: String!
    @NSManaged public var hp: NSDecimalNumber!
    @NSManaged public var hpRegen: NSDecimalNumber!
    @NSManaged public var magicResistance: NSDecimalNumber!
    @NSManaged public var mana: NSDecimalNumber!
    @NSManaged public var manaRegen: NSDecimalNumber!
    @NSManaged public var projectileSpeed: NSDecimalNumber!
    @NSManaged public var speed: NSDecimalNumber!
    @NSManaged public var spellDamage: NSDecimalNumber!
    @NSManaged public var vision: String!
    @NSManaged public var hero: Hero!

}
