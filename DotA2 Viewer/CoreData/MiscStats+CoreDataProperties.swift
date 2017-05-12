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
    @NSManaged public var attackRange: Double
    @NSManaged public var baseAttackTime: Double
    @NSManaged public var collisionSize: Double
    @NSManaged public var magicResistance: Double
    @NSManaged public var movementSpeed: Double
    @NSManaged public var projectileSpeed: Double
    @NSManaged public var turnRate: Double
    @NSManaged public var visionRange: String
    @NSManaged public var hero: Hero

}
