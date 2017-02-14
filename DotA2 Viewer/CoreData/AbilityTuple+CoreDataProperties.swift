//
//  AbilityTuple+CoreDataProperties.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-02-13.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import CoreData


extension AbilityTuple {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AbilityTuple> {
        return NSFetchRequest<AbilityTuple>(entityName: "AbilityTuple");
    }

    @NSManaged public var value: String?
    @NSManaged public var abilityData: Ability?
    @NSManaged public var abilityType: Ability?
    @NSManaged public var dataItem: DataItem?

}
