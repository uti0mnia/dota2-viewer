//
//  Damage+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2016-11-30.
//
//

import Foundation
import CoreData


extension Damage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Damage> {
        return NSFetchRequest<Damage>(entityName: "Damage");
    }

    @NSManaged public var max: NSNumber?
    @NSManaged public var min: NSNumber?
    @NSManaged public var stats: BaseStat?

}
