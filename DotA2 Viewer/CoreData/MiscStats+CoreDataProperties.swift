//
//  MiscStats+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData


extension MiscStats {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MiscStats> {
        return NSFetchRequest<MiscStats>(entityName: "MiscStats")
    }

    @NSManaged public var attackAnimation: String
    @NSManaged public var attackRange: Int16
    @NSManaged public var baseAttackTime: NSDecimalNumber
    @NSManaged public var collisionSize: Int16
    @NSManaged public var magicResistance: NSDecimalNumber
    @NSManaged public var movementSpeed: Int16
    @NSManaged public var projectileSpeed: Int16
    @NSManaged public var turnRate: NSDecimalNumber
    @NSManaged public var visionRange: String
    @NSManaged public var hero: Hero

}
