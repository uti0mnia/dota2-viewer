//
//  Recipe+CoreDataProperties.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-10-11.
//  Copyright © 2016 self. All rights reserved.
//

import Foundation
import CoreData

extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe");
    }

    @NSManaged public var name: String?
    @NSManaged public var item: Item?

}
