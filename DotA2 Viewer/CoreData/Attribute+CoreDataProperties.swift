//
//  Attribute+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2016-11-30.
//
//

import Foundation
import CoreData


extension Attribute {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attribute> {
        return NSFetchRequest<Attribute>(entityName: "Attribute");
    }

    @NSManaged public var base: NSDecimalNumber?
    @NSManaged public var increment: NSDecimalNumber?
    @NSManaged public var isPrimary: NSNumber?
    @NSManaged public var name: String?
    @NSManaged public var hero: Hero?

}
