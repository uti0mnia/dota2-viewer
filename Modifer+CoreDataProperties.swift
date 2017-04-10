//
//  Modifer+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2017-04-10.
//
//

import Foundation
import CoreData


extension Modifer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Modifer> {
        return NSFetchRequest<Modifer>(entityName: "Modifer")
    }

    @NSManaged public var colour: Int16
    @NSManaged public var ability: Ability?

}
