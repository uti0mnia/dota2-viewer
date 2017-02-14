//
//  AbilityModifier+CoreDataProperties.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-02-13.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import CoreData


extension AbilityModifier {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AbilityModifier> {
        return NSFetchRequest<AbilityModifier>(entityName: "AbilityModifier");
    }

    @NSManaged public var colour: NSNumber?
    @NSManaged public var value: String?
    @NSManaged public var ability: Ability?

}
