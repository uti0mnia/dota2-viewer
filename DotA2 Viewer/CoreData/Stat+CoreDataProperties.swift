//
//  Stat+CoreDataProperties.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-15.
//  Copyright © 2016 self. All rights reserved.
//

import Foundation
import CoreData


extension Stat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stat> {
        return NSFetchRequest<Stat>(entityName: "Stat");
    }

    @NSManaged public var armor: String?
    @NSManaged public var attackRange: String?
    @NSManaged public var damage: String?
    @NSManaged public var hp: String?
    @NSManaged public var level: String?
    @NSManaged public var mana: String?
    @NSManaged public var missleSpeed: String?
    @NSManaged public var sight: String?
    @NSManaged public var hero: Hero?

}
