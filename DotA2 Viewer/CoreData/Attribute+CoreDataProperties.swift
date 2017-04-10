//
//  Attribute+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData


extension Attribute {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attribute> {
        return NSFetchRequest<Attribute>(entityName: "Attribute")
    }

    @NSManaged public var base: NSDecimalNumber?
    @NSManaged public var increment: NSDecimalNumber?
    @NSManaged public var isPrimary: Bool
    @NSManaged public var type: Int16
    @NSManaged public var hero: Hero?

}
