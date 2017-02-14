//
//  HeroMiscStat+CoreDataProperties.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-02-13.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import CoreData


extension HeroMiscStat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HeroMiscStat> {
        return NSFetchRequest<HeroMiscStat>(entityName: "HeroMiscStat");
    }

    @NSManaged public var attackRange: NSNumber?
    @NSManaged public var attackTime: NSNumber?
    @NSManaged public var collisionSize: NSNumber?
    @NSManaged public var magicResistance: NSNumber?
    @NSManaged public var movementSpeed: NSNumber?
    @NSManaged public var projectileSpeed: NSNumber?
    @NSManaged public var turnRate: NSNumber?
    @NSManaged public var attackAnimation: Tuple?
    @NSManaged public var hero: Hero?
    @NSManaged public var visionRange: Tuple?

}
