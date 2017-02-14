//
//  HeroBaseStat+CoreDataProperties.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-02-13.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import CoreData


extension HeroBaseStat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HeroBaseStat> {
        return NSFetchRequest<HeroBaseStat>(entityName: "HeroBaseStat");
    }

    @NSManaged public var armor: NSNumber?
    @NSManaged public var attackPerSecond: NSNumber?
    @NSManaged public var hp: NSNumber?
    @NSManaged public var hpRegen: NSNumber?
    @NSManaged public var mana: NSNumber?
    @NSManaged public var manaRegen: NSNumber?
    @NSManaged public var spellDamage: NSNumber?
    @NSManaged public var damage: Tuple?
    @NSManaged public var hero: Hero?

}
