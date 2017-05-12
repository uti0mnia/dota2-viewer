//
//  Attribute+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2017-04-11.
//
//

import Foundation
import CoreData


extension Attribute {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attribute> {
        return NSFetchRequest<Attribute>(entityName: "Attribute")
    }

    @NSManaged public var base: Double
    @NSManaged public var increment: Double
    @NSManaged public var isPrimary: Bool
    @NSManaged public var type: Int16
    @NSManaged public var hero: Hero

}
