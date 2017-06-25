//
//  Modifier+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2017-04-15.
//
//

import Foundation
import CoreData


extension Modifier {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Modifier> {
        return NSFetchRequest<Modifier>(entityName: "Modifier")
    }

    @NSManaged public var colour: Int16
    @NSManaged public var ability: Ability?

}
