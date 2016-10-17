//
//  Item+CoreDataProperties.swift
//  DotA2 Viewer
//
//  Created by Casey McLewin on 2016-10-15.
//  Copyright © 2016 self. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item");
    }

    @NSManaged public var cooldown: String?
    @NSManaged public var cost: String?
    @NSManaged public var data: String?
    @NSManaged public var id: String?
    @NSManaged public var info: String?
    @NSManaged public var lore: String?
    @NSManaged public var mana: String?
    @NSManaged public var type: String?
    @NSManaged public var recipe: NSSet?

}

// MARK: Generated accessors for recipe
extension Item {

    @objc(addRecipeObject:)
    @NSManaged public func addToRecipe(_ value: Recipe)

    @objc(removeRecipeObject:)
    @NSManaged public func removeFromRecipe(_ value: Recipe)

    @objc(addRecipe:)
    @NSManaged public func addToRecipe(_ values: NSSet)

    @objc(removeRecipe:)
    @NSManaged public func removeFromRecipe(_ values: NSSet)

}
