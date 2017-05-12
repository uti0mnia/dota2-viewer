//
//  Talent+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData


extension Talent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Talent> {
        return NSFetchRequest<Talent>(entityName: "Talent")
    }

    @NSManaged public var left: String
    @NSManaged public var level: Int16
    @NSManaged public var right: String
    @NSManaged public var hero: Hero

}
