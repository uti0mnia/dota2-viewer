//
//  Talent+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2016-12-19.
//
//

import Foundation
import CoreData


extension Talent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Talent> {
        return NSFetchRequest<Talent>(entityName: "Talent");
    }

    @NSManaged public var level: NSDecimalNumber?
    @NSManaged public var left: String?
    @NSManaged public var right: String?
    @NSManaged public var hero: Hero?

}
