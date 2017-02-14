//
//  DataItem+CoreDataProperties.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-02-13.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import CoreData


extension DataItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataItem> {
        return NSFetchRequest<DataItem>(entityName: "DataItem");
    }

    @NSManaged public var aghs: String?
    @NSManaged public var normal: String?
    @NSManaged public var talent: String?
    @NSManaged public var talentAghs: String?
    @NSManaged public var type: NSNumber?
    @NSManaged public var abilityCooldown: Ability?
    @NSManaged public var abilityMana: Ability?
    @NSManaged public var abilityTuple: AbilityTuple?

}
