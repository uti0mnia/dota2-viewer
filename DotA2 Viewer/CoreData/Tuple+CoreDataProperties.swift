//
//  Tuple+CoreDataProperties.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-02-13.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import CoreData


extension Tuple {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tuple> {
        return NSFetchRequest<Tuple>(entityName: "Tuple");
    }

    @NSManaged public var first: NSNumber?
    @NSManaged public var second: NSNumber?
    @NSManaged public var attackAnimation: HeroMiscStat?
    @NSManaged public var itemCost: Item?
    @NSManaged public var stats: HeroBaseStat?
    @NSManaged public var visionRange: HeroMiscStat?

}
