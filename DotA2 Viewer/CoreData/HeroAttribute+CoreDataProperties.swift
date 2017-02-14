//
//  HeroAttribute+CoreDataProperties.swift
//  DotA2 Assistant
//
//  Created by Casey McLewin on 2017-02-13.
//  Copyright © 2017 self. All rights reserved.
//

import Foundation
import CoreData


extension HeroAttribute {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HeroAttribute> {
        return NSFetchRequest<HeroAttribute>(entityName: "HeroAttribute");
    }

    @NSManaged public var base: NSNumber?
    @NSManaged public var increment: NSNumber?
    @NSManaged public var isPrimary: NSNumber?
    @NSManaged public var type: NSNumber?
    @NSManaged public var hero: Hero?

}
