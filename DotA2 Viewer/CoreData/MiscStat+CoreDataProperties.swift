//
//  MiscStat+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2016-11-30.
//
//

import Foundation
import CoreData


extension MiscStat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MiscStat> {
        return NSFetchRequest<MiscStat>(entityName: "MiscStat");
    }

    @NSManaged public var attackAnimation: String?
    @NSManaged public var attackRange: NSDecimalNumber?
    @NSManaged public var attackTime: NSDecimalNumber?
    @NSManaged public var attribute: NSDecimalNumber?
    @NSManaged public var collisionSize: NSDecimalNumber?
    @NSManaged public var magicResistance: NSDecimalNumber?
    @NSManaged public var movementSpeed: NSDecimalNumber?
    @NSManaged public var projectileSpeed: String?
    @NSManaged public var turnRate: NSDecimalNumber?
    @NSManaged public var visionRange: String?
    @NSManaged public var hero: Hero?

}
