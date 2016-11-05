//
//  PrimaryStat+CoreDataProperties.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-15.
//  Copyright © 2016 self. All rights reserved.
//

import Foundation
import CoreData


extension PrimaryStat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PrimaryStat> {
        return NSFetchRequest<PrimaryStat>(entityName: "PrimaryStat");
    }

    @NSManaged public var agility: String?
    @NSManaged public var armor: String?
    @NSManaged public var damage: String?
    @NSManaged public var intelligence: String?
    @NSManaged public var speed: String?
    @NSManaged public var strength: String?
    @NSManaged public var hero: Hero?

}
