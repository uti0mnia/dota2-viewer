//
//  ArrayItem+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData


extension ArrayItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArrayItem> {
        return NSFetchRequest<ArrayItem>(entityName: "ArrayItem")
    }

    @NSManaged public var value: String?
    @NSManaged public var hero: Hero?
    @NSManaged public var itemAdditionalInfo: Item?
    @NSManaged public var itemAvailability: Item?
    @NSManaged public var itemBuildsFrom: Item?
    @NSManaged public var itemBuildsInto: Item?

}
