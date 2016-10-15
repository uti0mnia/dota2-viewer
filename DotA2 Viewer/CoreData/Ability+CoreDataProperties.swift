//
//  Ability+CoreDataProperties.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-15.
//  Copyright © 2016 self. All rights reserved.
//

import Foundation
import CoreData

extension Ability {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ability> {
        return NSFetchRequest<Ability>(entityName: "Ability");
    }

    @NSManaged public var cooldown: String?
    @NSManaged public var data: String?
    @NSManaged public var lore: String?
    @NSManaged public var mana: String?
    @NSManaged public var name: String?
    @NSManaged public var summary: String?
    @NSManaged public var videoURL: String?
    @NSManaged public var hero: Hero?

}
