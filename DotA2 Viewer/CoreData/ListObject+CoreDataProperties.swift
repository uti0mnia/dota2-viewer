//
//  ListObject+CoreDataProperties.swift
//  
//
//  Created by Casey McLewin on 2016-11-30.
//
//

import Foundation
import CoreData


extension ListObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListObject> {
        return NSFetchRequest<ListObject>(entityName: "ListObject");
    }

    @NSManaged public var name: String!
    @NSManaged public var image: NSData?

}
